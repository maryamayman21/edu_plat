import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/utils/Assets/appAssets.dart';
import '../../application/app_bar_cubit.dart';
class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  @override
  final Size preferredSize;

  CustomAppbar({Key? key})
      : preferredSize = Size.fromHeight(130.0),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      scrolledUnderElevation: 0,
      toolbarHeight: 130.h,
      title: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 30.h),
          ScaleTransition(
              scale:  context.watch<AppBarCubit>().state,
              child: Image.asset(
                AppAssets.eduPlat,
              )),

        ],
      ),
      centerTitle: true,
      actions: [
        Padding(
          padding: REdgeInsets.only(right: 10),
          child: Icon(
            Icons.notifications_active,
            color: Colors.grey,
            size: 30.r,
          ),
        ),
      ],
    );
  }
}
