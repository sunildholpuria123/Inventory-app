class SyncJsonHelper {
  const SyncJsonHelper._();

  static String? toIso(DateTime? value) {
    return value?.toIso8601String();
  }
}