import 'package:flutter/foundation.dart';

import 'sync_device.dart';
import 'sync_module.dart';
import 'sync_operation.dart';

@immutable
class SyncSession {
  final String id;

  /// Sender / Receiver / Two Way
  final SyncOperation operation;

  /// Selected Modules
  final List<SyncModule> modules;

  /// Remote Device
  final SyncDevice? device;

  /// Session Start Time
  final DateTime startedAt;

  const SyncSession({
    required this.id,
    required this.operation,
    required this.modules,
    required this.startedAt,
    this.device,
  });

  SyncSession copyWith({
    String? id,
    SyncOperation? operation,
    List<SyncModule>? modules,
    SyncDevice? device,
    DateTime? startedAt,
  }) {
    return SyncSession(
      id: id ?? this.id,
      operation: operation ?? this.operation,
      modules: modules ?? this.modules,
      device: device ?? this.device,
      startedAt: startedAt ?? this.startedAt,
    );
  }
}