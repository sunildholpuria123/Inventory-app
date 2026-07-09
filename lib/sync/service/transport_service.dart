import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';

class
TransportService {
  static const int defaultPort = 40402;

  ServerSocket? _server;
  Socket? _socket;

  final StreamController<Uint8List> _packetController  =
  StreamController<Uint8List>.broadcast();

  final StreamController<bool> _connectionController =
  StreamController<bool>.broadcast();

  Stream<Uint8List> get packets => _packetController .stream;

  Stream<bool> get connection => _connectionController.stream;

  bool get isConnected => _socket != null;

  final List<int> _buffer = [];

  int? _expectedLength;
  InternetAddress? get remoteAddress =>
      _socket?.remoteAddress;
  int? get remotePort =>
      _socket?.remotePort;

  //==========================================================
  // SERVER
  //==========================================================

  Future<void> startServer({
    int port = defaultPort,
  }) async {
    if (_server != null) return;

    _server = await ServerSocket.bind(
      InternetAddress.anyIPv4,
      port,
    );

    _server!.listen(_acceptClient);
  }

  void _acceptClient(Socket socket) {
    _attach(socket);
  }

  //==========================================================
  // CLIENT
  //==========================================================

  Future<void> connect({
    required String ip,
    int port = defaultPort,
  }) async {
    await disconnect();

    final socket = await Socket.connect(
      ip,
      port,
      timeout: const Duration(seconds: 5),
    );
    socket.setOption(
      SocketOption.tcpNoDelay,
      true,
    );

    _attach(socket);
  }

  //==========================================================
  // COMMON
  //==========================================================

  void _attach(Socket socket) {
    _socket = socket;

    _connectionController.add(true);

    socket.listen(
      _onData,
      onDone: disconnect,
      onError: (_) => disconnect(),
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
      debugPrint("[TRANSPORT] Packet received: ${packet.length} bytes");
      _packetController.add(packet);
    }
  }

  //==========================================================
  // SEND
  //==========================================================

  Future<void> send(
      Uint8List bytes,
      ) async {
    final socket = _socket;

    if (socket == null) {
      throw Exception(
        'No active connection.',
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
  }

  //==========================================================
  // DISCONNECT
  //==========================================================

  Future<void> disconnect() async {
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
  }

  //==========================================================
  // STOP SERVER
  //==========================================================

  Future<void> stopServer() async {
    await disconnect();

    await _server?.close();

    _server = null;
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