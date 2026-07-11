import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../service/conflict_resolver.dart';

final conflictResolverProvider = Provider<ConflictResolver>(
  (_) => const ConflictResolver(),
);
