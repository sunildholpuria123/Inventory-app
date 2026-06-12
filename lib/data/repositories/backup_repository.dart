import 'dart:io';

import '../../core/services/backup_service.dart';
import '../../core/services/google_drive_service.dart';

class BackupRepository {
  /// CREATE + UPLOAD
  Future<File> backupToGoogle() async {
    try {
      final backup = await BackupService.createBackup();

      await GoogleDriveService.uploadBackup(backup);

      return backup;
    } catch (e) {
      rethrow;
    }
  }

  /// LOCAL BACKUP
  Future<File> localBackup() async {
    return BackupService.createBackup();
  }

  /// RESTORE
  Future<void> restore(File file) async {
    await BackupService.restoreBackup(file);
  }
}
