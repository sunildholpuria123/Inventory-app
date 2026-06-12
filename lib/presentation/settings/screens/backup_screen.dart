import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider/backup_provider.dart';

class BackupScreen extends ConsumerStatefulWidget {
  const BackupScreen({super.key});

  @override
  ConsumerState<BackupScreen> createState() => _BackupScreenState();
}

class _BackupScreenState extends ConsumerState<BackupScreen> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            const Text(
              'Backup & Restore',

              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 30),

            ElevatedButton.icon(
              onPressed: isLoading
                  ? null
                  : () async {
                      setState(() {
                        isLoading = true;
                      });

                      try {
                        final repo = ref.read(backupRepositoryProvider);

                        await repo.backupToGoogle();

                        if (mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Backup uploaded to Google Drive'),
                            ),
                          );
                        }
                      } finally {
                        if (mounted) {
                          setState(() {
                            isLoading = false;
                          });
                        }
                      }
                    },

              icon: const Icon(Icons.cloud_upload),

              label: const Text('Backup To Google Drive'),
            ),

            const SizedBox(height: 20),

            ElevatedButton.icon(
              onPressed: () async {
                final result = await FilePicker.platform.pickFiles(
                  type: FileType.custom,

                  allowedExtensions: ['zip'],
                );

                if (result == null) {
                  return;
                }

                final path = result.files.single.path;

                if (path == null) {
                  return;
                }

                final repo = ref.read(backupRepositoryProvider);

                await repo.restore(File(path));
                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Database restored successfully'),
                    ),
                  );
                }
              },

              icon: const Icon(Icons.restore),

              label: const Text('Restore Backup'),
            ),
          ],
        ),
      ),
    );
  }
}
