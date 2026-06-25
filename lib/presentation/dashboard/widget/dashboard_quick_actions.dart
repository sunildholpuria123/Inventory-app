import 'package:flutter/material.dart';

class DashboardQuickActions
    extends StatelessWidget {
  const DashboardQuickActions({
    super.key,
  });

  @override
  Widget build(
      BuildContext context,
      ) {
    return Wrap(
      spacing: 16,
      runSpacing: 16,
      children: [
        _action(
          context,
          Icons.point_of_sale,
          'New Sale',
        ),
        _action(
          context,
          Icons.shopping_bag,
          'Purchase',
        ),
        _action(
          context,
          Icons.person_add,
          'Customer',
        ),
        _action(
          context,
          Icons.inventory_2,
          'Product',
        ),
      ],
    );
  }

  Widget _action(
      BuildContext context,
      IconData icon,
      String title,
      ) {
    return SizedBox(
      width: 130,
      child: Card(
        child: Padding(
          padding:
          const EdgeInsets.all(
            20,
          ),
          child: Column(
            children: [
              Icon(
                icon,
                size: 34,
              ),
              const SizedBox(
                height: 12,
              ),
              Text(title),
            ],
          ),
        ),
      ),
    );
  }
}