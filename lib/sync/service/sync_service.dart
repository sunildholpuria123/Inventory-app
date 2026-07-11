import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';

import '../model/message_type.dart';
import '../model/network_message.dart';
import '../model/sync_device.dart';
import '../model/sync_progress.dart';
import '../model/sync_result.dart';
import '../model/sync_status.dart';
import '../model/sync_table.dart';
import '../repository/sync_repository.dart';
import '../utils/sync_codec.dart';
import 'SyncProgressManager.dart';
import 'discovery_service.dart';
import 'transport_service.dart';

class SyncService {
  final SyncRepository repository;
  final DiscoveryService discovery;
  final TransportService transport;
  final SyncCodec codec;

  SyncService({
    required this.repository,
    required this.discovery,
    required this.transport,
    required this.codec,
  });

  static const Duration _ackTimeout = Duration(seconds: 30);

  Stream<List<SyncDevice>> get devices => discovery.devices;

  Stream<bool> get connection => transport.connection;

  bool get isConnected => transport.isConnected;

  final SyncProgressManager progressManager =
  SyncProgressManager();

  Stream<SyncProgress> get progress =>
      progressManager.stream;

  StreamSubscription<Uint8List>? _packetSubscription;

  SyncDevice? _currentDevice;

  Completer<void>? _ackCompleter;

  bool _isSyncing = false;

  bool get isSyncing => _isSyncing;

  //-------------------------------------------------------
  // START
  //-------------------------------------------------------

  Future<void> start({required SyncDevice currentDevice}) async {
    _currentDevice = currentDevice;

    await discovery.start(currentDevice: currentDevice);

    await transport.startServer();

    await _packetSubscription?.cancel();

    _packetSubscription = transport.packets.listen(_onPacketReceived);

    debugPrint("[SYNC] Service started");
  }

  //-------------------------------------------------------
  // SEARCH DEVICES
  //-------------------------------------------------------

  Future<void> searchDevices() async {
    if (_currentDevice == null) {
      throw Exception("SyncService not initialized.");
    }

    await discovery.search();
  }

  //-------------------------------------------------------
  // CONNECT
  //-------------------------------------------------------

  Future<void> connect(SyncDevice device) async {
    debugPrint("[SYNC] Connecting to ${device.name}");

    await transport.connect(ip: device.ip, port: device.port);
  }

  //-------------------------------------------------------
  // DISCONNECT
  //-------------------------------------------------------

  Future<void> disconnect() async {
    await transport.disconnect();
  }

  //-------------------------------------------------------
  // SEND DATABASE
  //-------------------------------------------------------

  Future<void> sendDatabase({required List<SyncTable> tables}) async {
    if (_currentDevice == null) {
      throw Exception("SyncService not initialized.");
    }

    debugPrint("[SYNC] Exporting database...");

    _emitProgress(
      status: SyncStatus.exporting,
      message: "Exporting database...",
      progress: 0.20,
    );

    final packet = await repository.exportData(
      deviceId: _currentDevice!.id,
      deviceName: _currentDevice!.name,
      tables: tables,
    );

    debugPrint("[SYNC] Export complete");

    debugPrint(
      "[SYNC] Customers : ${(packet.payload['customers'] as List?)?.length ?? 0}",
    );

    debugPrint(
      "[SYNC] Products  : ${(packet.payload['products'] as List?)?.length ?? 0}",
    );

    _emitProgress(
      status: SyncStatus.compressing,
      message: "Compressing database...",
      progress: 0.35,
    );

    final message = NetworkMessage(
      type: MessageType.sync,
      payload: codec.encodeBase64(packet),
    );

    final bytes = Uint8List.fromList(utf8.encode(message.encode()));

    debugPrint("[SYNC] Sending ${bytes.length} bytes");

    await transport.send(bytes);

    debugPrint("[SYNC] Database sent");
  }

  //-------------------------------------------------------
  // PROGRESS
  //-------------------------------------------------------

  void _emitProgress({
    required SyncStatus status,
    required String message,
    required double progress,
  }) {
    progressManager.emit(
      status: SyncStatus.exporting,
      message: 'Exporting database...',
      progress: 0.20,
    );
  }

  //-------------------------------------------------------
  // RECEIVE DATABASE
  //-------------------------------------------------------

  Future<void> _onPacketReceived(Uint8List bytes) async {
    try {
      final networkMessage = NetworkMessage.decode(utf8.decode(bytes));

      debugPrint("[SYNC] Received : ${networkMessage.type}");

      switch (networkMessage.type) {
        //---------------------------------------------------
        // SYNC
        //---------------------------------------------------
        case MessageType.sync:
          _emitProgress(
            status: SyncStatus.importing,
            message: "Importing database...",
            progress: 0.95,
          );

          final packet = codec.decodeBase64(networkMessage.payload!);

          await repository.importData(packet);

          debugPrint("[SYNC] Import completed");

          final ack = NetworkMessage(type: MessageType.ack);

          await transport.send(Uint8List.fromList(utf8.encode(ack.encode())));

          break;

        //---------------------------------------------------
        // ACK
        //---------------------------------------------------
        case MessageType.ack:
          if (_ackCompleter != null && !_ackCompleter!.isCompleted) {
            debugPrint("[SYNC] ACK received");

            _ackCompleter!.complete();
          }
          break;

        //---------------------------------------------------
        // ERROR
        //---------------------------------------------------
        case MessageType.error:
          if (_ackCompleter != null && !_ackCompleter!.isCompleted) {
            _ackCompleter!.completeError(
              networkMessage.message ?? "Unknown sync error",
            );
          }

          break;

        //---------------------------------------------------
        // HANDSHAKE
        //---------------------------------------------------
        case MessageType.handshake:
          debugPrint("[SYNC] Handshake received");

          final ack = NetworkMessage(type: MessageType.ack);

          await transport.send(Uint8List.fromList(utf8.encode(ack.encode())));

          break;

        //---------------------------------------------------
        // PING
        //---------------------------------------------------
        case MessageType.ping:
          final pong = NetworkMessage(type: MessageType.pong);

          await transport.send(Uint8List.fromList(utf8.encode(pong.encode())));

          break;

        //---------------------------------------------------
        // PONG
        //---------------------------------------------------
        case MessageType.pong:
          debugPrint("[SYNC] Pong received");
          break;

        //---------------------------------------------------
        // CANCEL
        //---------------------------------------------------
        case MessageType.cancel:
          debugPrint("[SYNC] Cancel received");
          break;

        //---------------------------------------------------
        // PROGRESS
        //---------------------------------------------------
        case MessageType.progress:
          debugPrint("[SYNC] Progress received");
          break;
      }
    } catch (e, stackTrace) {
      debugPrint("[SYNC] Receive error : $e");

      debugPrint(stackTrace.toString());

      final error = NetworkMessage(
        type: MessageType.error,
        message: e.toString(),
      );

      await transport.send(Uint8List.fromList(utf8.encode(error.encode())));
    }
  }

  //-------------------------------------------------------
  // SYNC
  //-------------------------------------------------------

  Future<SyncResult> syncToDevice({
    required SyncDevice device,
    required List<SyncTable> tables,
  }) async {
    if (_isSyncing) {
      throw Exception("Synchronization already running.");
    }

    _isSyncing = true;

    _ackCompleter = Completer<void>();

    final stopwatch = Stopwatch()..start();

    try {
      _emitProgress(
        status: SyncStatus.connecting,
        message: "Connecting...",
        progress: 0.05,
      );

      await connect(device);

      await sendDatabase(tables: tables);

      _emitProgress(
        status: SyncStatus.waitingAck,
        message: "Waiting for ACK...",
        progress: 0.90,
      );

      await _ackCompleter!.future.timeout(_ackTimeout);

      stopwatch.stop();

      _emitProgress(
        status: SyncStatus.completed,
        message: "Synchronization completed.",
        progress: 1.0,
      );

      debugPrint("[SYNC] Completed in ${stopwatch.elapsed}");

      return SyncResult.success(stopwatch.elapsed);
    } catch (e) {
      stopwatch.stop();

      _emitProgress(
        status: SyncStatus.failed,
        message: e.toString(),
        progress: 0,
      );

      debugPrint("[SYNC] Failed : $e");

      return SyncResult.failure(e.toString(), stopwatch.elapsed);
    } finally {
      await disconnect();

      _ackCompleter = null;

      _isSyncing = false;
    }
  }

  //-------------------------------------------------------
  // STOP
  //-------------------------------------------------------

  Future<void> stop() async {
    await discovery.stop();

    await transport.stopServer();
  }

  //-------------------------------------------------------
  // DISPOSE
  //-------------------------------------------------------

  Future<void> dispose() async {
    await _packetSubscription?.cancel();

    await stop();

    await discovery.dispose();

    await transport.dispose();

    await progressManager.dispose();
  }
}
