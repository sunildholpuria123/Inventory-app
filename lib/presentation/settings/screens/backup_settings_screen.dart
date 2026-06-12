import 'package:flutter/material.dart';

import '../../../core/services/auto_backup_service.dart';
import '../../../core/services/backup_service.dart';
import '../widgets/backup_history_widget.dart';

class BackupSettingsScreen extends StatelessWidget {
  const BackupSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final backupService = BackupService();

    final autoBackupService = AutoBackupService();

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Text(
              'Backup & Restore',
              style: Theme.of(context).textTheme.headlineMedium,
            ),

            const SizedBox(height: 30),

            Card(
              child: Padding(
                padding: const EdgeInsets.all(20),

                child: Column(
                  children: [
                    ListTile(
                      leading: const Icon(Icons.backup),

                      title: const Text('Backup Database'),

                      subtitle: const Text('Export SQLite database'),

                      trailing: ElevatedButton(
                        onPressed: () async {
                          await backupService.backupDatabase();

                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Backup Completed')),
                            );
                          }
                        },

                        child: const Text('Backup'),
                      ),
                    ),

                    const Divider(),

                    ListTile(
                      leading: const Icon(Icons.restore),

                      title: const Text('Restore Database'),

                      subtitle: const Text('Import SQLite backup'),

                      trailing: ElevatedButton(
                        onPressed: () async {
                          await backupService.restoreDatabase();

                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Restore Completed'),
                              ),
                            );
                          }
                        },

                        child: const Text('Restore'),
                      ),
                    ),

                    const Divider(),

                    ListTile(
                      leading: const Icon(Icons.history),

                      title: const Text('Auto Backup'),

                      subtitle: const Text('Create automatic backup'),

                      trailing: ElevatedButton(
                        onPressed: () async {
                          await autoBackupService.createAutoBackup();

                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Auto Backup Created'),
                              ),
                            );
                          }
                        },

                        child: const Text('Run'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            Expanded(child: BackupHistoryWidget()),
          ],
        ),
      ),
    );
  }
}
