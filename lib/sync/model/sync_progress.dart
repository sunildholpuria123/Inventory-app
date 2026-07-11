import 'sync_status.dart';

class SyncProgress {
  final SyncStatus status;

  final String message;

  final double progress;

  const SyncProgress({
    required this.status,
    required this.message,
    required this.progress,
  });

  factory SyncProgress.idle() {
    return const SyncProgress(
      status: SyncStatus.idle,
      message: '',
      progress: 0,
    );
  }
}