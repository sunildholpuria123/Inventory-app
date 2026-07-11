import 'package:flutter/material.dart';

class SettingsTile extends StatelessWidget {
  final IconData icon;
  final Color? iconColor;

  final String title;
  final String? subtitle;

  final VoidCallback? onTap;

  final Widget? trailing;

  const SettingsTile({
    super.key,
    required this.icon,
    required this.title,
    this.subtitle,
    this.iconColor,
    this.trailing,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 14,
        ),
        child: Row(
          children: [
            Container(
              width: 46,
              height: 46,
              decoration: BoxDecoration(
                color: (iconColor ?? theme.colorScheme.primary)
                    .withOpacity(.12),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                color: iconColor ?? theme.colorScheme.primary,
                size: 24,
              ),
            ),

            const SizedBox(width: 16),

            Expanded(
              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: theme.textTheme.titleMedium
                        ?.copyWith(
                      fontWeight:
                      FontWeight.w600,
                    ),
                  ),

                  if (subtitle != null &&
                      subtitle!.isNotEmpty)
                    Padding(
                      padding:
                      const EdgeInsets.only(
                        top: 4,
                      ),
                      child: Text(
                        subtitle!,
                        style: theme
                            .textTheme.bodySmall
                            ?.copyWith(
                          color: Colors.grey[600],
                        ),
                      ),
                    ),
                ],
              ),
            ),

            trailing ??
                const Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 18,
                ),
          ],
        ),
      ),
    );
  }
}