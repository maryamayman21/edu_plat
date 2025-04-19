import 'package:flutter/material.dart';

/// A custom delegate for the pinned tab bar
class TabBarDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;

  TabBarDelegate({required this.child});

  @override
  Widget build(BuildContext context, double shrinkOffset,
      bool overlapsContent) {
    return Material(

      child: Container(
        color: Colors.white, // Background color for the pinned area
        child: child,
      ),
    );
  }

  @override
  double get maxExtent => 42.0; // Height of the tab bar
  @override
  double get minExtent => 42.0; // Height of the tab bar

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true; // No need to rebuild
  }
}
