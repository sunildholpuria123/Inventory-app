import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';

import '../network/network_constants.dart';

class TransportService {
  static const int defaultPort = NetworkConstants.transportPort;

  ServerSocket? _server;
  Socket? _socket;

  StreamSubscription<Socket>? _serverSubscription;
  StreamSubscription<Uint8List>? _clientSubscription;

  final StreamController<Uint8List> _packetController =
  StreamController<Uint8List>.broadcast();

  final StreamController<bool> _connectionController =
  StreamController<bool>.broadcast();

  Stream<Uint8List> get packets => _packetController.stream;

  Stream<bool> get connection => _connectionController.stream;

  bool get isConnected => _socket != null;

  InternetAddress? get remoteAddress => _socket?.remoteAddress;

  int? get remotePort => _socket?.remotePort;

  final List<int> _buffer = [];

  int? _expectedLength;

  bool _sending = false;

  //==========================================================
  // SERVER
  //==========================================================

  Future<void> startServer() async {
    if (_server != null) {
      return;
    }

    _server = await ServerSocket.bind(
      InternetAddress.anyIPv4,
      defaultPort,
      shared: true,
    );

    _serverSubscription = _server!.listen(
      _handleClient,
      onError: _onServerError,
    );

    debugPrint(
      "[TRANSPORT] Server started on port $defaultPort",
    );
  }

  void _handleClient(Socket socket) async {
    debugPrint(
      "[TRANSPORT] Incoming connection : ${socket.remoteAddress.address}",
    );

    await disconnect();

    _attach(socket);
  }

  void _onServerError(Object error) {
    debugPrint(
      "[TRANSPORT] Server Error : $error",
    );
  }

  //==========================================================
  // CLIENT
  //==========================================================

  Future<void> connect({
    required String ip,
    int port = defaultPort,
  }) async {
    await disconnect();

    debugPrint(
      "[TRANSPORT] Connecting to $ip:$port",
    );

    final socket = await Socket.connect(
      ip,
      port,
      timeout: NetworkConstants.connectTimeout,
    );

    socket.setOption(
      SocketOption.tcpNoDelay,
      true,
    );

    _attach(socket);

    debugPrint("[TRANSPORT] Connected");
  }

  //==========================================================
  // ATTACH SOCKET
  //==========================================================

  void _attach(Socket socket) {
    _socket = socket;

    _connectionController.add(true);

    _clientSubscription?.cancel();

    _clientSubscription = socket.listen(
      _onData,
      onDone: _onDisconnected,
      onError: _onSocketError,
      cancelOnError: true,
    );
  }

  //==========================================================
  // RECEIVE
  //==========================================================

  void _onData(Uint8List data) {
    _buffer.addAll(data);

    while (true) {
      if (_expectedLength == null) {
        if (_buffer.length < 4) {
          return;
        }

        final header = ByteData.sublistView(
          Uint8List.fromList(_buffer.sublist(0, 4)),
        );

        _expectedLength = header.getUint32(0);

        if (_expectedLength! <= 0 ||
            _expectedLength! >
                NetworkConstants.maxPacketSize) {
          debugPrint(
            "[TRANSPORT] Invalid packet length : $_expectedLength",
          );

          disconnect();

          return;
        }

        _buffer.removeRange(0, 4);
      }

      if (_buffer.length < _expectedLength!) {
        return;
      }

      final packet = Uint8List.fromList(
        _buffer.sublist(
          0,
          _expectedLength!,
        ),
      );

      _buffer.removeRange(
        0,
        _expectedLength!,
      );

      _expectedLength = null;

      debugPrint(
        "[TRANSPORT] Packet received : ${packet.length} bytes",
      );

      _packetController.add(packet);
    }
  }

  //==========================================================
  // SEND
  //==========================================================

  Future<void> send(
      Uint8List bytes,
      ) async {
    while (_sending) {
      await Future.delayed(
        const Duration(milliseconds: 5),
      );
    }

    _sending = true;

    try {
      final socket = _socket;

      if (socket == null) {
        throw Exception(
          "No active socket connection.",
        );
      }

      final header = ByteData(4)
        ..setUint32(
          0,
          bytes.length,
        );

      socket.add(
        header.buffer.asUint8List(),
      );

      socket.add(bytes);

      await socket.flush();

      debugPrint(
        "[TRANSPORT] Packet sent : ${bytes.length} bytes",
      );
    } finally {
      _sending = false;
    }
  }

  //==========================================================
  // DISCONNECT
  //==========================================================

  Future<void> disconnect() async {
    await _clientSubscription?.cancel();
    _clientSubscription = null;

    final socket = _socket;

    _socket = null;

    if (socket != null) {
      try {
        await socket.flush();
      } catch (_) {}

      try {
        await socket.close();
      } catch (_) {}
    }

    _buffer.clear();

    _expectedLength = null;

    _connectionController.add(false);

    debugPrint("[TRANSPORT] Disconnected");
  }

  void _onDisconnected() {
    debugPrint(
      "[TRANSPORT] Remote disconnected",
    );

    disconnect();
  }

  void _onSocketError(Object error) {
    debugPrint(
      "[TRANSPORT] Socket Error : $error",
    );

    disconnect();
  }

  //==========================================================
  // STOP SERVER
  //==========================================================

  Future<void> stopServer() async {
    await disconnect();

    await _serverSubscription?.cancel();
    _serverSubscription = null;

    await _server?.close();
    _server = null;

    debugPrint(
      "[TRANSPORT] Server stopped",
    );
  }

  //==========================================================
  // DISPOSE
  //==========================================================

  Future<void> dispose() async {
    await stopServer();

    await _packetController.close();

    await _connectionController.close();
  }
}