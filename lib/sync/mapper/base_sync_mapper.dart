import '../context/sync_export_context.dart';
import '../context/sync_import_context.dart';

abstract class BaseSyncMapper<T, C> {
  Map<String, dynamic> toMap(T data, SyncExportContext context);

  C toCompanion(Map<String, dynamic> json, SyncImportContext context);
}
