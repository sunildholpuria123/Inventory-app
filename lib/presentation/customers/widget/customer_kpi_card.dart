import 'package:flutter/material.dart';

class CustomerKpiCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  /// NEW
  final VoidCallback? onTap;

  const CustomerKpiCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(24),
        child: Card(
          elevation: 0,
          margin: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    color: color.withOpacity(.12),
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Icon(
                    icon,
                    color: color,
                    size: 28,
                  ),
                ),

                const SizedBox(width: 16),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(
                          context,
                        ).textTheme.bodyMedium?.copyWith(
                          color: Colors.grey.shade700,
                        ),
                      ),

                      const SizedBox(height: 6),

                      FittedBox(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          value,
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                if (onTap != null)
                  const Icon(
                    Icons.chevron_right,
                    size: 20,
                    color: Colors.grey,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}