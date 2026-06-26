import 'package:flutter/material.dart';

class CustomerTimelineWidget extends StatelessWidget {
  const CustomerTimelineWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Customer Timeline',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            const Text('Connect existing ledger and payment history here.'),
          ],
        ),
      ),
    );
  }
}
