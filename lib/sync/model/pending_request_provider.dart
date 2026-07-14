import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/pending_sync_request.dart';

final pendingSyncRequestProvider =
StateProvider<PendingSyncRequest?>(
      (ref)=>null,
);