import 'dart:async';
import 'dart:convert';
import 'dart:io';

import '../model/sync_device.dart';

class DiscoveryService {
  static const int discoveryPort = 40401;

  RawDatagramSocket? _socket;

  final List<SyncDevice> _devices = [];

  final StreamController<List<SyncDevice>> _controller =
  StreamController.broadcast();

  Stream<List<SyncDevice>> get devices => _controller.stream;

  List<SyncDevice> get currentDevices =>
      List.unmodifiable(_devices);

  SyncDevice? _currentDevice;

  /// Start listening
  Future<void> start({
    required SyncDevice currentDevice,
  }) async {
    if (_socket != null) return;

    _currentDevice = currentDevice;

    _socket = await RawDatagramSocket.bind(
      InternetAddress.anyIPv4,
      discoveryPort,
      reuseAddress: true);

    _socket!
      ..broadcastEnabled = true
      ..listen(_onSocketEvent);
  }

  /// Search nearby devices

  Future<void> search({
    required SyncDevice currentDevice,
  }) async {
    if (_socket == null) {
      throw Exception('DiscoveryService not started');
    }

    final data = jsonEncode({
      "type": "DISCOVER_REQUEST",
      "id": currentDevice.id,
      "name": currentDevice.name,
      "port": currentDevice.port,
      "desktop": currentDevice.isDesktop,
    });

    await _socket!.send(
      utf8.encode(data),
      InternetAddress("255.255.255.255"),
      discoveryPort,
    );
  }

  void _onSocketEvent(
      RawSocketEvent event,
      ) {
    if (event != RawSocketEvent.read) {
      return;
    }

    final datagram = _socket?.receive();

    if (datagram == null) {
      return;
    }

    try {
      final json = jsonDecode(
        utf8.decode(datagram.data),
      );

      switch (json["type"]) {
        case "DISCOVER_REQUEST":
          _handleRequest(
            json,
            datagram.address,
          );
          break;

        case "DISCOVER_RESPONSE":
          _handleResponse(
            json,
            datagram.address,
          );
          break;
      }
    } catch (_) {}
  }

  void _handleRequest(
      Map<String, dynamic> json,
      InternetAddress sender,
      ) {
    if (_currentDevice == null) return;

    if (json["id"] == _currentDevice!.id) {
      return;
    }

    final response = {
      "type": "DISCOVER_RESPONSE",
      "id": _currentDevice!.id,
      "name": _currentDevice!.name,
      "port": _currentDevice!.port,
      "desktop": _currentDevice!.isDesktop,
    };

    _socket?.send(
      utf8.encode(jsonEncode(response)),
      sender,
      discoveryPort,
    );
  }

  void _handleResponse(
      Map<String, dynamic> json,
      InternetAddress sender,
      ) {
    if (_currentDevice == null) return;

    if (json["id"] == _currentDevice!.id) {
      return;
    }

    final device = SyncDevice(
      id: json["id"],
      name: json["name"],
      ip: sender.address,
      port: json["port"],
      isDesktop: json["desktop"],
    );

    final index = _devices.indexWhere(
          (e) => e.id == device.id,
    );

    if (index == -1) {
      _devices.add(device);
    } else {
      _devices[index] = device;
    }

    _devices.sort(
          (a, b) => a.name.compareTo(b.name),
    );

    _controller.add(
      List.unmodifiable(_devices),
    );
  }

  Future<void> stop() async {
    _socket?.close();
    _socket = null;

    _devices.clear();

    _controller.add([]);
  }

  Future<void> dispose() async {
    await stop();
    await _controller.close();
  }
}