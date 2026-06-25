import 'package:flutter/material.dart';

class SalesTabBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar tabBar;

  SalesTabBarDelegate(this.tabBar);

  @override
  double get minExtent => tabBar.preferredSize.height;

  @override
  double get maxExtent => tabBar.preferredSize.height;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(18),
        ),
        child: tabBar,
      ),
    );
  }

  @override
  bool shouldRebuild(SalesTabBarDelegate oldDelegate) {
    return false;
  }
}
