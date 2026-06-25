import 'package:flutter/material.dart';

class AppSection extends StatelessWidget {
  final String title;
  final Widget child;
  final Widget? action;

  const AppSection({
    super.key,
    required this.title,
    required this.child,
    this.action,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding:
        const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment:
          CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  title,
                  style:
                  Theme.of(context)
                      .textTheme
                      .titleLarge,
                ),
                const Spacer(),
                if (action != null)
                  action!,
              ],
            ),
            const SizedBox(height: 20),
            child,
          ],
        ),
      ),
    );
  }
}