import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';

class NetworkService {
  const NetworkService();

  /// Returns true if device is connected to
  /// WiFi or Ethernet.
  Future<bool> isConnected() async {
    final connectivity = await Connectivity().checkConnectivity();

    return connectivity.contains(ConnectivityResult.wifi) ||
        connectivity.contains(ConnectivityResult.ethernet);
  }

  /// Returns current connectivity type.
  Future<ConnectivityResult> getConnectionType() async {
    final connectivity = await Connectivity().checkConnectivity();

    if (connectivity.isEmpty) {
      return ConnectivityResult.none;
    }

    return connectivity.first;
  }

  /// Returns local IPv4 address.
  Future<String?> getLocalIp() async {
    try {
      final interfaces = await NetworkInterface.list(
        includeLoopback: false,
        type: InternetAddressType.IPv4,
      );

      for (final interface in interfaces) {
        for (final address in interface.addresses) {
          if (!address.isLoopback) {
            return address.address;
          }
        }
      }
    } catch (_) {}

    return null;
  }

  /// Returns device hostname.
  Future<String> getHostName() async {
    return Platform.localHostname;
  }

  /// Returns true if current IP belongs
  /// to a local LAN.
  Future<bool> isOnLocalNetwork() async {
    final ip = await getLocalIp();

    if (ip == null) {
      return false;
    }

    return ip.startsWith("192.168.") ||
        ip.startsWith("10.") ||
        ip.startsWith("172.");
  }
}