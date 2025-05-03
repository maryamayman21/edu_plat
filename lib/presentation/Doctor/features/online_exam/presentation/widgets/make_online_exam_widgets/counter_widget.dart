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
    required this.color, this.isDuration = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Define text styles internally
     TextStyle valueTextStyle = TextStyle(
      fontSize: 20.sp,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    );

     TextStyle labelTextStyle = TextStyle(
      fontSize: 12.sp,
      fontWeight: FontWeight.w600,
      color: Colors.white,
    );

    return Container(
      padding:  EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      margin: EdgeInsets.symmetric(horizontal: 18.w),
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
        children: [
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 800), // Fixed duration
            transitionBuilder: (Widget child, Animation<double> animation) {
              // Flip animation
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
              key: ValueKey<int>(value), // Unique key for each value
              isDuration ? '${value.toString()} min' :
              value.toString(),
              style: valueTextStyle,
            ),
          ),
        //  const SizedBox(height: 3),
          Text(
            label,
            style: labelTextStyle,
          ),
        ],
      ),
    );
  }
}