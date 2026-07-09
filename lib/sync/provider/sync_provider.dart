import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/providers/database_provider.dart';
import '../repository/sync_repository.dart';
import '../service/discovery_service.dart';
import '../service/sync_service.dart';
import '../model/sync_statistics.dart';
import '../service/transport_service.dart';
import '../utils/sync_codec.dart';

final syncRepositoryProvider = Provider<SyncRepository>((ref) {
  return SyncRepository(
    ref.watch(databaseProvider),
  );
});

final syncServiceProvider = Provider<SyncService>((ref) {
  return SyncService(
    repository: ref.watch(syncRepositoryProvider),
    discovery: DiscoveryService(),
    transport: TransportService(),
    codec: const SyncCodec(),
  );
});

final syncStatisticsProvider =
FutureProvider<SyncStatistics>((ref) {
  return ref
      .watch(syncRepositoryProvider)
      .getStatistics();
});