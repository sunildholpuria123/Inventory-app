import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_plus/share_plus.dart';

import '../../../core/provider/theme_provider.dart';
import '../../../core/services/backup_service.dart';
import '../../../core/services/demo_data_service.dart';
import '../../../core/services/notification_service.dart';
import '../../../data/providers/database_provider.dart';
import '../../../data/repositories/backup_repository.dart'
    show BackupRepository;
import '../../categories/screen/category_management_screen.dart';
import '../provider/backup_provider.dart';
import '../provider/settings_provider.dart';
import '../widgets/settings_header.dart';
import '../widgets/settings_quick_actions.dart';
import '../widgets/settings_section.dart';
import '../widgets/settings_tile.dart';
import 'business_settings_screen.dart';

import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider/backup_provider.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsProvider);
    final brightness = Theme.of(context).brightness;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),

        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SettingsHeader(
                companyName: settings.companyName,
                gstNumber: "N/A",
                phone: "N/A",
                email: "N/A",
              ),

              const SizedBox(height: 24),

              SettingsQuickActions(
                onBusiness: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const BusinessSettingsScreen(),
                    ),
                  );
                },
                onBackup: () async {
                  final repo = ref.read(backupRepositoryProvider);

                  final file = await repo.localBackup();

                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Backup saved\n$file')),
                    );
                  }
                },
                onRestore: () async {
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
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Database restored successfully'),
                      ),
                    );
                  }
                },
                onExport: () async {
                  final file = await BackupService().createAndExportBackup();

                  if (file != null && context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Backup exported to\n${file.path}'),
                      ),
                    );
                  }
                },
              ),

              const SizedBox(height: 28),

              /// BUSINESS
              SettingsSection(
                title: 'Business',
                icon: Icons.business,
                children: [
                  SettingsTile(
                    icon: Icons.apartment,
                    title: 'Company Details',
                    subtitle: 'Company name, logo & address',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const BusinessSettingsScreen(),
                        ),
                      );
                    },
                  ),

                  SettingsTile(
                    icon: Icons.receipt_long,
                    title: 'GST Settings',
                    subtitle: 'GSTIN & Tax',
                    onTap: () {},
                  ),

                  SettingsTile(
                    icon: Icons.currency_rupee,
                    title: 'Currency',
                    subtitle: settings.currency,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const BusinessSettingsScreen(),
                        ),
                      );
                    },
                  ),
                ],
              ),

              /// BILLING
              SettingsSection(
                title: 'Billing',
                icon: Icons.request_quote,
                children: [
                  SettingsTile(
                    icon: Icons.description,
                    title: 'Invoice Settings',
                    subtitle: 'Invoice Prefix & Number',
                    onTap: () {},
                  ),

                  SettingsTile(
                    icon: Icons.percent,
                    title: 'Tax Settings',
                    subtitle: 'Default Tax',
                    onTap: () {},
                  ),

                  SettingsTile(
                    icon: Icons.payments,
                    title: 'Payment Methods',
                    subtitle: 'Cash / UPI / Card',
                    onTap: () {},
                  ),
                ],
              ),

              /// INVENTORY
              SettingsSection(
                title: 'Inventory',
                icon: Icons.inventory_2,
                children: [
                  SettingsTile(
                    icon: Icons.warning_amber,
                    title: 'Low Stock Alert',
                    subtitle: 'Minimum stock warning',
                    onTap: () {},
                  ),

                  SettingsTile(
                    icon: Icons.straighten,
                    title: 'Default Unit',
                    subtitle: 'PCS',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const CategoryManagementScreen(),
                        ),
                      );
                    },
                  ),
                ],
              ),

              /// BACKUP
              SettingsSection(
                title: 'Backup & Restore',
                icon: Icons.backup,
                children: [
                  SettingsTile(
                    icon: Icons.upload_file,
                    title: 'Export Database',
                    subtitle: 'Export or Share backup ZIP',
                    onTap: () async {
                      if (!context.mounted) return;

                      await showModalBottomSheet(
                        context: context,
                        showDragHandle: true,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(24),
                          ),
                        ),
                        builder: (sheetContext) {
                          return SafeArea(
                            child: Padding(
                              padding: const EdgeInsets.all(20),
                              child: Wrap(
                                runSpacing: 8,
                                children: [
                                  Text(
                                    'Database Backup',
                                    style: Theme.of(sheetContext)
                                        .textTheme
                                        .titleLarge
                                        ?.copyWith(fontWeight: FontWeight.bold),
                                  ),

                                  const SizedBox(height: 8),

                                  const Text(
                                    'Choose what you want to do with the generated backup.',
                                  ),

                                  const SizedBox(height: 20),

                                  ListTile(
                                    leading: const CircleAvatar(
                                      child: Icon(Icons.folder_open),
                                    ),
                                    title: const Text('Export & Open'),
                                    subtitle: const Text(
                                      'Generate backup and open it',
                                    ),
                                    onTap: () async {
                                      Navigator.pop(sheetContext);

                                      final file = await BackupService()
                                          .createAndExportBackup();

                                      if (file != null && context.mounted) {
                                        ScaffoldMessenger.of(
                                          context,
                                        ).showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              'Backup exported successfully\n${file.path}',
                                            ),
                                          ),
                                        );
                                      }
                                    },
                                  ),

                                  ListTile(
                                    leading: const CircleAvatar(
                                      child: Icon(Icons.share),
                                    ),
                                    title: const Text('Export & Share'),
                                    subtitle: const Text(
                                      'Generate backup and share ZIP',
                                    ),
                                    onTap: () async {
                                      Navigator.pop(sheetContext);

                                      final file = await BackupService()
                                          .createAndExportBackup();

                                      if (file == null) return;

                                      await SharePlus.instance.share(
                                        ShareParams(
                                          files: [XFile(file.path)],
                                          subject: 'Inventory ERP Backup',
                                          text: 'Inventory ERP Database Backup',
                                        ),
                                      );
                                    },
                                  ),

                                  const Divider(height: 24),

                                  ListTile(
                                    leading: const CircleAvatar(
                                      child: Icon(Icons.close),
                                    ),
                                    title: const Text('Cancel'),
                                    onTap: () => Navigator.pop(sheetContext),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                  SettingsTile(
                    icon: Icons.download,
                    title: 'Import Database',
                    subtitle: 'Restore backup',
                    onTap: () {},
                  ),
                ],
              ),

              /// APPEARANCE
              SettingsSection(
                title: 'Appearance',
                icon: Icons.palette,
                children: [
                  SettingsTile(
                    icon: Icons.dark_mode,
                    title: 'Dark Mode',
                    subtitle: 'Coming Soon',
                    trailing: Switch(
                      value: ref.watch(themeModeProvider) == ThemeMode.dark,

                      onChanged: (value) {
                        ref.read(themeModeProvider.notifier).state = value
                            ? ThemeMode.dark
                            : ThemeMode.light;
                      },
                    ),
                  ),
                ],
              ),

              SettingsSection(
                title: 'Tools',
                icon: Icons.build,
                children: [
                  SettingsTile(
                    icon: Icons.notifications_active,
                    title: 'Test Notification',
                    subtitle: 'Send test notification',
                    onTap: () async {
                      await NotificationService.instance.showNotification(
                        id: 1,
                        title: 'Inventory ERP',
                        body: 'Notification test successful.',
                      );
                    },
                  ),
                  SettingsTile(
                    icon: Icons.data_object,
                    title: 'Load Demo Data',
                    subtitle: 'Insert sample records',
                    onTap: () async {
                      final confirm = await showDialog<bool>(
                        context: context,
                        builder: (_) => AlertDialog(
                          title: const Text('Load Demo Data'),
                          content: const Text(
                            'This will insert sample data into the database. Continue?',
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context, false),
                              child: const Text('Cancel'),
                            ),
                            FilledButton(
                              onPressed: () => Navigator.pop(context, true),
                              child: const Text('Continue'),
                            ),
                          ],
                        ),
                      );

                      if (confirm != true) return;

                      await DemoDataService(
                        ref.read(databaseProvider),
                      ).generate();
                    },
                  ),
                ],
              ),

              /// ABOUT
              SettingsSection(
                title: 'About',
                icon: Icons.info_outline,
                children: [
                  const SettingsTile(
                    icon: Icons.info,
                    title: 'Version',
                    subtitle: 'v1.0.0',
                  ),

                  SettingsTile(
                    icon: Icons.privacy_tip,
                    title: 'Privacy Policy',
                    subtitle: 'Read policy',
                    onTap: () {},
                  ),
                ],
              ),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),

      child: Text(
        title,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }
}
