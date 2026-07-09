abstract class BaseSyncMapper<T, C> {
  /// Drift row -> JSON
  Map<String, dynamic> toMap(T model);

  /// JSON -> Drift Companion
  C toCompanion(Map<String, dynamic> json);
}
