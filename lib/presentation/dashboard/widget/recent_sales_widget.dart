import 'package:flutter/material.dart';

class RecentSalesWidget
    extends StatelessWidget {
  const RecentSalesWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding:
        const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment:
          CrossAxisAlignment
              .start,

          children: [
            const Text(
              'Recent Sales',
              style: TextStyle(
                fontSize: 20,
                fontWeight:
                FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            Expanded(
              child: ListView.builder(
                itemCount: 5,

                itemBuilder:
                    (context, index) {
                  return ListTile(
                    leading:
                    const CircleAvatar(
                      child:
                      Icon(Icons.receipt),
                    ),

                    title: Text(
                      'Invoice #100$index',
                    ),

                    subtitle: const Text(
                      'Customer Name',
                    ),

                    trailing: const Text(
                      '₹5000',
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}