import 'package:flutter/material.dart';

import '../../../core/services/notification_service.dart';

class LowStockWidget
    extends StatelessWidget {
  const LowStockWidget({
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
              'Low Stock Alerts',
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
                    leading: const Icon(
                      Icons.warning,
                      color: Colors.red,
                    ),

                    title: Text(
                      'Product $index',
                    ),

                    trailing: const Text(
                      'Qty: 2',
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight:
                        FontWeight.bold,
                      ),
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