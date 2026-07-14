import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../model/trusted_device.dart';
import '../service/trusted_device_service.dart';

class SharedPrefsTrustedDeviceService
    implements TrustedDeviceService {
  static const _key = 'trusted_devices';

  Future<SharedPreferences> get _prefs =>
      SharedPreferences.getInstance();

  @override
  Future<bool> isTrusted(String deviceId) async {
    final devices = await getAll();

    return devices.any(
          (e) => e.deviceId == deviceId,
    );
  }

  @override
  Future<void> addTrusted(
      TrustedDevice device,
      ) async {
    final prefs = await _prefs;

    final devices = await getAll();

    devices.removeWhere(
          (e) => e.deviceId == device.deviceId,
    );

    devices.add(device);

    await prefs.setString(
      _key,
      jsonEncode(
        devices
            .map((e) => e.toJson())
            .toList(),
      ),
    );
  }

  @override
  Future<void> removeTrusted(
      String deviceId,
      ) async {
    final prefs = await _prefs;

    final devices = await getAll();

    devices.removeWhere(
          (e) => e.deviceId == deviceId,
    );

    await prefs.setString(
      _key,
      jsonEncode(
        devices
            .map((e) => e.toJson())
            .toList(),
      ),
    );
  }

  @override
  Future<List<TrustedDevice>> getAll() async {
    final prefs = await _prefs;

    final json = prefs.getString(_key);

    if (json == null || json.isEmpty) {
      return [];
    }

    final List list = jsonDecode(json);

    return list
        .map(
          (e) => TrustedDevice.fromJson(e),
    )
        .toList();
  }
}