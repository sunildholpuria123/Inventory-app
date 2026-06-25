import 'package:flutter/material.dart';

class DashboardStatCardV2
    extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;
  final String? subtitle;

  const DashboardStatCardV2({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
    this.subtitle,
  });

  @override
  Widget build(
      BuildContext context,
      ) {
    return Card(
      child: Padding(
        padding:
        const EdgeInsets.all(
          20,
        ),
        child: Column(
          crossAxisAlignment:
          CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration:
                  BoxDecoration(
                    color:
                    color.withOpacity(
                      .12,
                    ),
                    borderRadius:
                    BorderRadius.circular(
                      14,
                    ),
                  ),
                  child: Icon(
                    icon,
                    color: color,
                  ),
                ),

                const Spacer(),

                Icon(
                  Icons.trending_up,
                  color:
                  Colors.green,
                ),
              ],
            ),

            const Spacer(),

            Text(
              value,
              style:
              Theme.of(context)
                  .textTheme
                  .headlineSmall
                  ?.copyWith(
                fontWeight:
                FontWeight.bold,
              ),
            ),

            const SizedBox(
              height: 6,
            ),

            Text(title),

            if (subtitle != null)
              Text(
                subtitle!,
                style:
                Theme.of(context)
                    .textTheme
                    .bodySmall,
              ),
          ],
        ),
      ),
    );
  }
}