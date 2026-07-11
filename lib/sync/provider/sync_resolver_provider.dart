import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/providers/database_provider.dart';
import '../service/sync_id_resolver.dart';

final syncIdResolverProvider =
Provider<SyncIdResolver>((ref) {
  return SyncIdResolver(
    ref.watch(databaseProvider),
  );
});