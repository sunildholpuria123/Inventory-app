import 'dart:io';

import 'package:flutter/foundation.dart';

import 'sync_device.dart';

@immutable
class DiscoveredDevice {
  final SyncDevice device;

  final InternetAddress address;

  final int port;

  final DateTime lastSeen;

  final bool online;

  const DiscoveredDevice({
    required this.device,
    required this.address,
    required this.port,
    required this.lastSeen,
    this.online = true,
  });

  DiscoveredDevice copyWith({
    SyncDevice? device,
    InternetAddress? address,
    int? port,
    DateTime? lastSeen,
    bool? online,
  }) {
    return DiscoveredDevice(
      device: device ?? this.device,
      address: address ?? this.address,
      port: port ?? this.port,
      lastSeen: lastSeen ?? this.lastSeen,
      online: online ?? this.online,
    );
  }
}