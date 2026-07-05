import 'package:flutter/material.dart';

class SettingsQuickActions extends StatelessWidget {
  final VoidCallback? onBusiness;
  final VoidCallback? onBackup;
  final VoidCallback? onRestore;
  final VoidCallback? onExport;

  const SettingsQuickActions({
    super.key,
    this.onBusiness,
    this.onBackup,
    this.onRestore,
    this.onExport,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 700;

        return GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: isMobile ? 2 : 4,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: isMobile ? 1.2 : 1.45,
          children: [
            _QuickActionCard(
              title: 'Business',
              subtitle: 'Company Profile',
              icon: Icons.business,
              color: Colors.blue,
              onTap: onBusiness,
            ),
            _QuickActionCard(
              title: 'Backup',
              subtitle: 'Secure Database',
              icon: Icons.backup,
              color: Colors.green,
              onTap: onBackup,
            ),
            _QuickActionCard(
              title: 'Restore',
              subtitle: 'Import Backup',
              icon: Icons.restore,
              color: Colors.orange,
              onTap: onRestore,
            ),
            _QuickActionCard(
              title: 'Export',
              subtitle: 'Excel / PDF',
              icon: Icons.file_upload,
              color: Colors.deepPurple,
              onTap: onExport,
            ),
          ],
        );
      },
    );
  }
}

class _QuickActionCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final VoidCallback? onTap;

  const _QuickActionCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: onTap,
        child: Ink(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Theme.of(context).colorScheme.surface,
            border: Border.all(
              color: Theme.of(context).dividerColor.withOpacity(.15),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(.04),
                blurRadius: 12,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 46,
                  height: 46,
                  decoration: BoxDecoration(
                    color: color.withOpacity(.12),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Icon(
                    icon,
                    color: color,
                    size: 24,
                  ),
                ),

                const Spacer(),

                Text(
                  title,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  subtitle,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}