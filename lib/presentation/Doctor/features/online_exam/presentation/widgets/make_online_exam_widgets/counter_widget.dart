import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AnimatedCounter extends StatelessWidget {
  final int value;
  final String label;
  final Color color;
  final bool isDuration;

  const AnimatedCounter({
    Key? key,
    required this.value,
    required this.label,
    required this.color,
    this.isDuration = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Responsive sizing based on available width
        final isSmallScreen = constraints.maxWidth < 300;

        return Container(
          padding: EdgeInsets.symmetric(
            horizontal: isSmallScreen ? 12.w : 20.w,
            vertical: isSmallScreen ? 8.h : 10.h,
          ),
          margin: EdgeInsets.symmetric(
            horizontal: isSmallScreen ? 8.w : 18.w,
          ),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(15.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 10.r,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 800),
                transitionBuilder: (Widget child, Animation<double> animation) {
                  return RotationTransition(
                    turns: Tween<double>(begin: 0.5, end: 1.0).animate(
                      CurvedAnimation(parent: animation, curve: Curves.easeInOut),
                    ),
                    child: FadeTransition(
                      opacity: Tween<double>(begin: 0.0, end: 1.0).animate(
                        CurvedAnimation(parent: animation, curve: Curves.easeInOut),
                      ),
                      child: child,
                    ),
                  );
                },
                child: Text(
                  key: ValueKey<int>(value),
                  isDuration ? '${value.toString()} min' : value.toString(),
                  style: TextStyle(
                    fontSize: isSmallScreen ? 16.sp : 18.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: isSmallScreen ? 2.h : 3.h),
              Text(
                label,
                style: TextStyle(
                  fontSize: isSmallScreen ? 10.sp : 11.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        );
      },
    );
  }
}