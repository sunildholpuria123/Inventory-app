import 'package:flutter/material.dart';

class RecentPaymentsWidget extends StatelessWidget {
  const RecentPaymentsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Recent Payments',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            const Text('Connect existing payment history provider here.'),
          ],
        ),
      ),
    );
  }
}
