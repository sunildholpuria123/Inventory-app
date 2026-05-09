import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

class BackupHistoryWidget
    extends StatefulWidget {
  const BackupHistoryWidget({
    super.key,
  });

  @override
  State<BackupHistoryWidget>
  createState() =>
      _BackupHistoryWidgetState();
}

class _BackupHistoryWidgetState
    extends State<
        BackupHistoryWidget> {
  List<FileSystemEntity> backups = [];

  @override
  void initState() {
    super.initState();

    loadBackups();
  }

  Future<void> loadBackups() async {
    final appDir =
    await getApplicationDocumentsDirectory();

    final backupDir = Directory(
      p.join(
        appDir.path,
        'auto_backups',
      ),
    );

    if (await backupDir.exists()) {
      backups = backupDir.listSync();

      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListView.builder(
        itemCount: backups.length,

        itemBuilder: (context, index) {
          final file =
          backups[index];

          return ListTile(
            leading:
            const Icon(Icons.storage),

            title: Text(
              p.basename(
                file.path,
              ),
            ),
          );
        },
      ),
    );
  }
}