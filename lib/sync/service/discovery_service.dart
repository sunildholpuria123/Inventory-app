import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';

import '../model/sync_device.dart';

class DiscoveryService {
  static const int discoveryPort = 40401;

  RawDatagramSocket? _socket;

  final Map<String, SyncDevice> _devices = {};

  final Map<String, DateTime> _lastSeen = {};

  final StreamController<List<SyncDevice>> _controller =
      StreamController<List<SyncDevice>>.broadcast();

  Timer? _cleanupTimer;

  SyncDevice? _currentDevice;

  Stream<List<SyncDevice>> get devices => _controller.stream;

  List<SyncDevice> get currentDevices =>
      _devices.values.toList(growable: false);

  //==========================================================
  // START
  //==========================================================

  Future<void> start({required SyncDevice currentDevice}) async {
    if (_socket != null) return;

    _currentDevice = currentDevice;

    _socket = await RawDatagramSocket.bind(
      InternetAddress.anyIPv4,
      discoveryPort,
      reuseAddress: true,
    );

    _socket!
      ..broadcastEnabled = true
      ..listen(_onSocketEvent);

    _cleanupTimer = Timer.periodic(
      const Duration(seconds: 15),
      (_) => _removeOfflineDevices(),
    );

    debugPrint("[DISCOVERY] Started");
  }

  //==========================================================
  // SEARCH
  //==========================================================

  Future<void> search() async {
    if (_socket == null || _currentDevice == null) {
      throw Exception("DiscoveryService has not been started.");
    }

    final request = {
      "type": "DISCOVER_REQUEST",
      "id": _currentDevice!.id,
      "name": _currentDevice!.name,
      "port": _currentDevice!.port,
      "desktop": _currentDevice!.isDesktop,
    };

    await _socket!.send(
      utf8.encode(jsonEncode(request)),
      InternetAddress("255.255.255.255"),
      discoveryPort,
    );

    debugPrint("[DISCOVERY] Broadcast sent");
  }

  //==========================================================
  // SOCKET
  //==========================================================

  void _onSocketEvent(RawSocketEvent event) {
    if (event != RawSocketEvent.read) {
      return;
    }

    final datagram = _socket?.receive();

    if (datagram == null) {
      return;
    }

    try {
      final json = jsonDecode(utf8.decode(datagram.data));

      switch (json["type"]) {
        case "DISCOVER_REQUEST":
          _handleRequest(json, datagram.address);
          break;

        case "DISCOVER_RESPONSE":
          _handleResponse(json, datagram.address);
          break;
      }
    } catch (e) {
      debugPrint("[DISCOVERY] Invalid packet : $e");
    }
  }

  //==========================================================
  // REQUEST
  //==========================================================

  void _handleRequest(Map<String, dynamic> json, InternetAddress sender) {
    if (_currentDevice == null) {
      return;
    }

    if (json["id"] == _currentDevice!.id) {
      return;
    }

    if (sender.address == _currentDevice!.ip) {
      return;
    }

    final response = {
      "type": "DISCOVER_RESPONSE",
      "id": _currentDevice!.id,
      "name": _currentDevice!.name,
      "port": _currentDevice!.port,
      "desktop": _currentDevice!.isDesktop,
    };

    _socket?.send(utf8.encode(jsonEncode(response)), sender, discoveryPort);
  }

  //==========================================================
  // RESPONSE
  //==========================================================

  void _handleResponse(Map<String, dynamic> json, InternetAddress sender) {
    if (_currentDevice == null) {
      return;
    }

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

    _devices[device.id] = device;

    _lastSeen[device.id] = DateTime.now();

    _emit();

    debugPrint("[DISCOVERY] Device : ${device.name} (${device.ip})");
  }

  //==========================================================
  // REMOVE OFFLINE DEVICES
  //==========================================================

  void _removeOfflineDevices() {
    final now = DateTime.now();

    _lastSeen.removeWhere((id, lastSeen) {
      final expired = now.difference(lastSeen).inSeconds > 30;

      if (expired) {
        _devices.remove(id);

        debugPrint("[DISCOVERY] Device removed : $id");
      }

      return expired;
    });

    _emit();
  }

  //==========================================================
  // EMIT
  //==========================================================

  void _emit() {
    final list = _devices.values.toList()
      ..sort((a, b) => a.name.compareTo(b.name));

    _controller.add(List.unmodifiable(list));
  }

  //==========================================================
  // STOP
  //==========================================================

  Future<void> stop() async {
    _cleanupTimer?.cancel();
    _cleanupTimer = null;

    _socket?.close();
    _socket = null;

    _devices.clear();
    _lastSeen.clear();

    _controller.add(const []);

    debugPrint("[DISCOVERY] Stopped");
  }

  //==========================================================
  // DISPOSE
  //==========================================================

  Future<void> dispose() async {
    await stop();

    await _controller.close();
  }
}
