import 'sync_device.dart';
import 'sync_table.dart';

class PendingSyncRequest {
  final SyncDevice sender;

  final List<SyncTable> tables;

  const PendingSyncRequest({
    required this.sender,
    required this.tables,
  });
}