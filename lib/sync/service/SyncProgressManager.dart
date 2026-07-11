import 'dart:async';

import '../model/sync_progress.dart';
import '../model/sync_status.dart';

class SyncProgressManager {
  final StreamController<SyncProgress> _controller =
  StreamController<SyncProgress>.broadcast();

  Stream<SyncProgress> get stream => _controller.stream;

  void emit({
    required SyncStatus status,
    required String message,
    required double progress,
  }) {
    _controller.add(
      SyncProgress(
        status: status,
        message: message,
        progress: progress,
      ),
    );
  }

  Future<void> dispose() async {
    await _controller.close();
  }
}