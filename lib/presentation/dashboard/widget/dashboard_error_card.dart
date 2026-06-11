import 'package:flutter/material.dart';

class DashboardErrorCard
    extends StatelessWidget {

  const DashboardErrorCard({
    super.key,
  });

  @override
  Widget build(
      BuildContext context) {

    return const Card(
      child: Center(
        child: Text(
          'Error',
        ),
      ),
    );
  }
}