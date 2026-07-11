class NetworkConstants {
  const NetworkConstants._();

  static const String appId = 'inventory_erp_sync';

  static const int protocolVersion = 1;

  static const int transportPort = 40402;

  static const String serviceType = '_inventoryerp._tcp';

  static const String serviceName = 'Inventory ERP Sync';

  static const Duration connectTimeout = Duration(seconds: 10);

  static const Duration ackTimeout = Duration(seconds: 30);

  static const int maxChunkSize = 256 * 1024;

  static const int maxPacketSize = 20 * 1024 * 1024;
}