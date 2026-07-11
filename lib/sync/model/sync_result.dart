class SyncResult {
  final bool success;

  final String message;

  final Duration duration;

  const SyncResult({
    required this.success,
    required this.message,
    required this.duration,
  });

  factory SyncResult.success(Duration duration) {
    return SyncResult(
      success: true,
      message: 'Synchronization completed successfully.',
      duration: duration,
    );
  }

  factory SyncResult.failure(
      String message,
      Duration duration,
      ) {
    return SyncResult(
      success: false,
      message: message,
      duration: duration,
    );
  }
}