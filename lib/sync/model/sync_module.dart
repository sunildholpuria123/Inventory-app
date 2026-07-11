import 'package:flutter/material.dart';

import 'sync_table.dart';

@immutable
class SyncModule {
  final SyncTable table;

  /// Stable key
  final String key;

  /// UI
  final String title;
  final String description;
  final IconData icon;
  final Color color;

  /// Execution order
  final int order;

  /// Default selected?
  final bool defaultSelected;

  const SyncModule({
    required this.table,
    required this.key,
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
    required this.order,
    this.defaultSelected = true,
  });
}