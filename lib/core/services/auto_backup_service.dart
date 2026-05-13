import 'dart:io';

import 'package:intl/intl.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart'
    show SharedPreferences;

import '../../data/repositories/backup_repository.dart' show BackupRepository;

class AutoBackupService {
  static Future<void> autoBackup() async {
    final prefs = await SharedPreferences.getInstance();

    final lastBackup = prefs.getString('last_backup');

    /// NO PREVIOUS BACKUP
    if (lastBackup == null) {
      await performBackup(prefs);

      return;
    }

    final previous = DateTime.parse(lastBackup);

    final now = DateTime.now();

    /// DAILY BACKUP
    if (now.difference(previous).inHours >= 24) {
      await performBackup(prefs);
    }
  }

  static Future<void> performBackup(SharedPreferences prefs) async {
    try {
      final repo = BackupRepository();

      await repo.backupToGoogle();

      await prefs.setString('last_backup', DateTime.now().toIso8601String());

      print('Auto backup completed');
    } catch (e) {
      print('Backup failed: $e');
    }
  }

  Future<void> createAutoBackup() async {
    final appDir = await getApplicationDocumentsDirectory();

    final dbPath = p.join(appDir.path, 'inventory.sqlite');

    final dbFile = File(dbPath);

    if (!await dbFile.exists()) {
      return;
    }

    final backupDir = Directory(p.join(appDir.path, 'auto_backups'));

    if (!await backupDir.exists()) {
      await backupDir.create(recursive: true);
    }

    final timestamp = DateFormat('yyyy_MM_dd_HH_mm').format(DateTime.now());

    final backupPath = p.join(backupDir.path, 'backup_$timestamp.sqlite');

    await dbFile.copy(backupPath);
  }
}
