

import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CourseDetailsShimmerEffect extends StatelessWidget {
  final double width;
  final double height;
  final double borderRadius;

  const CourseDetailsShimmerEffect({
    super.key,
    required this.width,
    required this.height,
    this.borderRadius = 8.0,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.blue[50]!,
      highlightColor: Colors.blue[100]!,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
    );
  }
}
