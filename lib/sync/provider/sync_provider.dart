import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:inventory_desktop/data/database/app_database.dart';

import '../../data/providers/database_provider.dart';

import '../../presentation/settings/provider/settings_provider.dart';
import '../model/sync_request.dart';
import '../model/sync_role.dart';
import '../model/sync_statistics.dart';
import '../repository/sync_history_repository.dart';
import '../repository/sync_repository.dart';

import '../service/conflict_resolver.dart';
import '../service/discovery_service.dart';
import '../service/sync_id_resolver.dart';
import '../service/sync_service.dart';
import '../service/transport_service.dart';

import '../model/database_statistics.dart';

import '../utils/sync_codec.dart';
import 'device_provider.dart';

///------------------------------------------------------------
/// Transport
///------------------------------------------------------------

final transportServiceProvider = Provider<TransportService>((ref) {
  final service = TransportService();

  ref.onDispose(service.dispose);

  return service;
});

///------------------------------------------------------------
/// Discovery
///------------------------------------------------------------

final discoveryServiceProvider = Provider<DiscoveryService>((ref) {
  final service = DiscoveryService();

  ref.onDispose(service.dispose);

  return service;
});

///------------------------------------------------------------
/// Conflict Resolver
///------------------------------------------------------------

final conflictResolverProvider = Provider<ConflictResolver>((ref) {
  return const ConflictResolver();
});

///------------------------------------------------------------
/// SyncId Resolver
///------------------------------------------------------------

final syncIdResolverProvider = Provider<SyncIdResolver>((ref) {
  return SyncIdResolver(ref.watch(databaseProvider));
});

///------------------------------------------------------------
/// Sync History
///------------------------------------------------------------

final syncHistoryRepositoryProvider = Provider<SyncHistoryRepository>((ref) {
  return SyncHistoryRepository(ref.watch(databaseProvider));
});

///------------------------------------------------------------
/// Repository
///------------------------------------------------------------

final syncRepositoryProvider = Provider<SyncRepository>((ref) {
  return SyncRepository(
    resolver: ref.watch(conflictResolverProvider),
    syncIdResolver: ref.watch(syncIdResolverProvider),
    historyRepository: ref.watch(syncHistoryRepositoryProvider),
    db: ref.watch(databaseProvider),
  );
});

///------------------------------------------------------------
/// Sync Service
///------------------------------------------------------------

final syncServiceProvider = Provider<SyncService>((ref) {
  final service = SyncService(
    repository: ref.watch(syncRepositoryProvider),
    discovery: ref.watch(discoveryServiceProvider),
    transport: ref.watch(transportServiceProvider),
    trustedService: ref.watch(trustedDeviceServiceProvider),
    codec: const SyncCodec(),
  );

  ref.onDispose(service.dispose);

  return service;
});

///------------------------------------------------------------
/// Statistics
///------------------------------------------------------------

final syncStatisticsProvider = FutureProvider<DatabaseStatistics>((ref) async {
  return ref.watch(syncRepositoryProvider).getStatistics();
});
final syncRoleProvider = StateProvider<SyncRole>((ref) => SyncRole.sender);
final incomingSyncRequestProvider = StateProvider<SyncRequest?>((ref) => null);
