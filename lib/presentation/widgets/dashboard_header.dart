import 'package:flutter/material.dart';

class DashboardHeader extends StatelessWidget {
  const DashboardHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
      MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment:
          CrossAxisAlignment.start,
          children: [
            Text(
              'Dashboard',
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium,
            ),

            const SizedBox(height: 5),

            Text(
              'Manage your inventory system',
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium,
            ),
          ],
        ),

        CircleAvatar(
          radius: 24,
          child: Icon(Icons.person),
        ),
      ],
    );
  }
}