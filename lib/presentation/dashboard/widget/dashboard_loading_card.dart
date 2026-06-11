import 'package:flutter/material.dart';

class DashboardLoadingCard
    extends StatelessWidget {

  const DashboardLoadingCard({
    super.key,
  });

  @override
  Widget build(
      BuildContext context) {

    return const Card(
      child: Center(
        child:
        CircularProgressIndicator(),
      ),
    );
  }
}