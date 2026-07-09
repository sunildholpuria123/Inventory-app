import '../model/sync_device.dart';
import 'discovery_service.dart';

/// Temporary wrapper.
/// Uses UDP discovery internally.
/// Can be replaced with a real mDNS implementation later.
class MdnsDiscoveryService extends DiscoveryService {
  @override
  Future<void> start({
    required SyncDevice currentDevice,
  }) {
    return super.start(
      currentDevice: currentDevice,
    );
  }

  @override
  Future<void> search({
    required SyncDevice currentDevice,
  }) {
    return super.search(
      currentDevice: currentDevice,
    );
  }

  @override
  Future<void> stop() {
    return super.stop();
  }

  @override
  Future<void> dispose() {
    return super.dispose();
  }
}