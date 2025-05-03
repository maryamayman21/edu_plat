import 'package:edu_platt/core/utils/Color/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class ContainerDrawer extends StatefulWidget {
  IconData icons;
  String text;
  final VoidCallback onTap;

  ContainerDrawer({
    required this.icons,
    required this.text,
    required this.onTap,
  });

  @override
  State<ContainerDrawer> createState() => _ContainerDrawerState();
}

class _ContainerDrawerState extends State<ContainerDrawer>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _animation = Tween<double>(begin: 1.0, end: 0.9).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: REdgeInsets.only(top: 30, left: 20),
      child: GestureDetector(
        onTap:widget.onTap,
        child: ScaleTransition(
          scale: _animation,
          child: Container(
            color: Colors.transparent,
            child: Row(
              children: [
                Icon(
                  widget.icons,
                  color: color.primaryColor,
                  size: 20.r,
                ),
                SizedBox(
                  width: 20.w,
                ),
                Text(
                  widget.text,
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: Colors.black,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w400),
                )
              ],
            ),
          ),
        )
        //     () {
        //   _controller.forward().then((_) {
        //     _controller.reverse();
        //     Future.delayed(const Duration(milliseconds: 100), () {
        //       //NavigationHelper.navigateWithAnimation(context, CoursesScreen());
        //       // Navigator.pop(context);
        //      widget.onTap();
        //     });
        //   });
        // },
      ),
    );
  }
}
