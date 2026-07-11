import 'package:flutter/material.dart';

class ProductAnalyticsCard
    extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const ProductAnalyticsCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
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
        child: Row(
          children: [
            CircleAvatar(
              radius: 28,
              backgroundColor:
              color.withOpacity(
                .12,
              ),
              child: Icon(
                icon,
                color: color,
              ),
            ),
            const SizedBox(
              width: 16,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment
                    .start,
                children: [
                  Text(title),
                  const SizedBox(
                    height: 6,
                  ),
                  Text(
                    value,
                    style:
                    Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(
                      fontWeight:
                      FontWeight
                          .bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}