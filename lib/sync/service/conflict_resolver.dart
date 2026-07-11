class ConflictResolver {
  const ConflictResolver();

  bool shouldUpdate({
    required DateTime localUpdatedAt,
    required DateTime remoteUpdatedAt,
  }) {
    return remoteUpdatedAt.isAfter(localUpdatedAt);
  }
}