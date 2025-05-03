import 'package:flutter/material.dart';

class CustomSwipeBackPage extends StatelessWidget {
  final Widget child;
  final VoidCallback onBack;

  CustomSwipeBackPage({required this.child, required this.onBack});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragUpdate: (details) {
        if (details.primaryDelta! > 5) {
          onBack();
        }
      },
      child: child,
    );
  }
}
