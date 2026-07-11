import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class DashboardKpiLoading
    extends StatelessWidget {
  const DashboardKpiLoading({
    super.key,
  });

  @override
  Widget build(
      BuildContext context,
      ) {
    return Skeletonizer(
      enabled: true,
      child: GridView.builder(
        shrinkWrap: true,
        itemCount: 4,
        physics:
        const NeverScrollableScrollPhysics(),
        gridDelegate:
        const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemBuilder:
            (_, __) => Card(
          child: Container(),
        ),
      ),
    );
  }
}