import 'package:flutter/material.dart';

class DashboardGrid extends StatelessWidget {
  final List<Widget> children;

  const DashboardGrid({
    super.key,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    final width =
        MediaQuery.sizeOf(context).width;

    int count = 2;
    double ratio = 1.1;

    if (width >= 1400) {
      count = 4;
      ratio = 1.45;
    } else if (width >= 900) {
      count = 3;
      ratio = 1.35;
    } else if (width >= 700) {
      count = 2;
      ratio = 1.25;
    }

    return GridView.builder(
      shrinkWrap: true,
      physics:
      const NeverScrollableScrollPhysics(),
      itemCount: children.length,
      gridDelegate:
      SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: count,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: ratio,
      ),
      itemBuilder:
          (_, index) =>
      children[index],
    );
  }
}