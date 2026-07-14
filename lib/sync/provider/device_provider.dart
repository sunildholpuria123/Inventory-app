import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/provider/network_provider.dart';
import '../service/device_service.dart';
import '../service/trusted_device_service.dart';
import '../utils/shared_prefs_trusted_device_service.dart';

final deviceServiceProvider = Provider<DeviceService>((ref) {
  return DeviceService(
    ref.read(networkServiceProvider),
  );
});

final trustedDeviceServiceProvider =
Provider<TrustedDeviceService>(
      (ref) {
    return SharedPrefsTrustedDeviceService();
  },
);