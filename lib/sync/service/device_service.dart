import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

import '../../core/services/network_service.dart';
import '../model/sync_device.dart';

class DeviceService {

  final NetworkService network;

  DeviceService(this.network);
  static const _deviceIdKey = 'sync_device_id';

  final DeviceInfoPlugin _deviceInfo = DeviceInfoPlugin();

  Future<SyncDevice> getCurrentDevice({
    required int port,
  }) async {
    final prefs = await SharedPreferences.getInstance();

    String? id = prefs.getString(_deviceIdKey);

    if (id == null) {
      id = const Uuid().v4();
      await prefs.setString(_deviceIdKey, id);
    }

    String name = 'Unknown Device';

    bool desktop = false;

    if (Platform.isAndroid) {
      final info = await _deviceInfo.androidInfo;
      name = "${info.brand} ${info.model}";
    } else if (Platform.isWindows) {
      desktop = true;
      final info = await _deviceInfo.windowsInfo;
      name = info.computerName;
    } else if (Platform.isLinux) {
      desktop = true;
      final info = await _deviceInfo.linuxInfo;
      name = info.prettyName;
    } else if (Platform.isMacOS) {
      desktop = true;
      final info = await _deviceInfo.macOsInfo;
      name = info.computerName;
    }

    return SyncDevice(
      id: id,
      name: name,
      ip: '',
      port: port,
      isDesktop: desktop,
    );
  }
}