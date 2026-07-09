import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';

import '../model/message_type.dart';
import '../model/network_message.dart';
import '../model/sync_device.dart';
import '../model/sync_progress.dart';
import '../model/sync_result.dart';
import '../model/sync_status.dart';
import '../model/sync_table.dart';
import '../repository/sync_repository.dart';
import '../utils/sync_codec.dart';
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

  Stream<List<SyncDevice>> get devices => discovery.devices;

  Stream<bool> get connection => transport.connection;

  bool get isConnected => transport.isConnected;

  StreamSubscription<Uint8List>? _packetSubscription;
  final _progressController = StreamController<SyncProgress>.broadcast();

  Stream<SyncProgress> get progress => _progressController.stream;

  SyncDevice? _currentDevice;
  Completer<void>? _ackCompleter;

  //-------------------------------------------------------
  // START
  //-------------------------------------------------------

  Future<void> start({required SyncDevice currentDevice}) async {
    _currentDevice = currentDevice;

    await discovery.start(currentDevice: currentDevice);
    await transport.startServer();

    _packetSubscription = transport.packets.listen(_onPacketReceived);
  }

  //-------------------------------------------------------
  // SEARCH DEVICES
  //-------------------------------------------------------

  Future<void> searchDevices() async {
    if (_currentDevice == null) {
      throw Exception('SyncService not initialized.');
    }

    await discovery.search(currentDevice: _currentDevice!);
  }

  //-------------------------------------------------------
  // CONNECT
  //-------------------------------------------------------

  Future<void> connect(SyncDevice device) {
    return transport.connect(ip: device.ip, port: device.port);
  }

  //-------------------------------------------------------
  // DISCONNECT
  //-------------------------------------------------------

  Future<void> disconnect() {
    return transport.disconnect();
  }

  //-------------------------------------------------------
  // SEND DATABASE
  //-------------------------------------------------------

  Future<void> sendDatabase({required List<SyncTable> tables}) async {
    debugPrint("[SYNC] Exporting database...");

    if (_currentDevice == null) {
      throw Exception("SyncService has not been initialized.");
    }

    final packet = await repository.exportData(
      deviceId: _currentDevice!.id,
      deviceName: _currentDevice!.name,
      tables: tables,
    );

    debugPrint("[SYNC] Packet created");
    debugPrint("[SYNC] Customers: ${(packet.payload['customers'] as List?)?.length}");
    debugPrint("[SYNC] Products : ${(packet.payload['products'] as List?)?.length}");


    final message = NetworkMessage(
      type: MessageType.sync,
      payload: codec.encodeBase64(packet),
    );

    _ackCompleter = Completer<void>();
    _emitProgress(
      status: SyncStatus.compressing,
      message: 'Compressing database...',
      progress: 0.35,
    );
    debugPrint(
      "[SYNC] Sending message size: ${utf8.encode(message.encode()).length}",
    );
    await transport.send(Uint8List.fromList(utf8.encode(message.encode())));

    await _ackCompleter!.future.timeout(const Duration(seconds: 30));
  }

  //-------------------------------------------------------
  // RECEIVE DATABASE
  //-------------------------------------------------------

  Future<void> _onPacketReceived(Uint8List bytes) async {
    try {
      debugPrint("[SYNC] _onPacketReceived()");
      final networkMessage = NetworkMessage.decode(utf8.decode(bytes));
      debugPrint("[SYNC] Message Type: ${networkMessage.type}");
      debugPrint("================================");
      debugPrint(networkMessage.encode());
      debugPrint("Type    : ${networkMessage.type}");
      debugPrint("Payload : ${networkMessage.payload?.length}");
      debugPrint("================================");
      switch (networkMessage.type) {
        case MessageType.sync:
          _emitProgress(
            status: SyncStatus.importing,
            message: "Importing database...",
            progress: 0.95,
          );

          final packet = codec.decodeBase64(networkMessage.payload!);
          debugPrint("[SYNC] Calling repository.importData()");
          await repository.importData(packet);
          debugPrint("[SYNC] importData() completed");
          final ack = NetworkMessage(type: MessageType.ack);

          await transport.send(Uint8List.fromList(utf8.encode(ack.encode())));

          break;

        case MessageType.ack:
          _ackCompleter?.complete();
          break;

        case MessageType.error:
          _ackCompleter?.completeError(
            networkMessage.message ?? "Unknown sync error",
          );
        case MessageType.cancel:
          debugPrint("Cancel message received.");
          break;

        case MessageType.progress:
          debugPrint("Progress message received.");
          break;


        case MessageType.ping:
          debugPrint("Ping received.");
          break;
      }
    } catch (e) {
      final error = NetworkMessage(
        type: MessageType.error,

        message: e.toString(),
      );

      await transport.send(Uint8List.fromList(utf8.encode(error.encode())));
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

    discovery.dispose();
    await _progressController.close();
    await transport.dispose();
  }

  void _emitProgress({
    required SyncStatus status,
    required String message,
    required double progress,
  }) {
    _progressController.add(
      SyncProgress(status: status, message: message, progress: progress),
    );
  }

  Future<SyncResult> syncToDevice({
    required SyncDevice device,
    required List<SyncTable> tables,
  }) async {
    final stopwatch = Stopwatch()..start();

    try {
      _emitProgress(
        status: SyncStatus.connecting,
        message: 'Connecting...',
        progress: 0.05,
      );

      await connect(device);

      _emitProgress(
        status: SyncStatus.exporting,
        message: 'Exporting database...',
        progress: 0.20,
      );

      await sendDatabase(tables: tables);

      _emitProgress(
        status: SyncStatus.waitingAck,
        message: 'Waiting for confirmation...',
        progress: 0.90,
      );

      await _ackCompleter!.future.timeout(const Duration(seconds: 30));

      stopwatch.stop();

      _emitProgress(
        status: SyncStatus.completed,
        message: 'Synchronization completed.',
        progress: 1,
      );

      await disconnect();

      return SyncResult.success(stopwatch.elapsed);
    } catch (e) {
      stopwatch.stop();

      await disconnect();

      _emitProgress(
        status: SyncStatus.failed,
        message: e.toString(),
        progress: 0,
      );

      return SyncResult.failure(e.toString(), stopwatch.elapsed);
    }
  }
}
