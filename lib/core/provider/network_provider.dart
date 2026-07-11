import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../sync/service/device_service.dart';
import '../services/network_service.dart';

final networkServiceProvider =
Provider<NetworkService>(
      (ref) {
    return const NetworkService();
  },
);
