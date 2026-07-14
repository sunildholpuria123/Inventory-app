import '../model/trusted_device.dart';

abstract class TrustedDeviceService {
  Future<bool> isTrusted(String deviceId);

  Future<void> addTrusted(
      TrustedDevice device,
      );

  Future<void> removeTrusted(
      String deviceId,
      );

  Future<List<TrustedDevice>> getAll();
}