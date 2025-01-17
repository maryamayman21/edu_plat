import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/utils/Color/color.dart';
class MyAppBar extends StatelessWidget  implements PreferredSizeWidget {
  @override
  final Size preferredSize;
    MyAppBar({super.key, required this.title, this.onPressed})
      : preferredSize = const Size.fromHeight(80.0); // Set the desired height

  final String title;
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return AppBar(

      backgroundColor: color.primaryColor,
      title:Text(
        title,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: Colors.white,
            fontSize: 26.sp,
            fontWeight: FontWeight.w800,
            fontFamily: 'Roboto-Mono'
        ),
      )
      ,
      toolbarHeight: 90.h,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30.r),
          bottomRight: Radius.circular(30.r),
        ),
      ),

      centerTitle: true,
      leading: IconButton(onPressed: onPressed, icon: const Icon(Icons.arrow_back, color: Colors.white,)),
    );
  }
}
