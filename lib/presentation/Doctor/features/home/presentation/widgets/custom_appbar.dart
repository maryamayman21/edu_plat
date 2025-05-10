import 'package:edu_platt/presentation/Routes/custom_pageRoute.dart';
import 'package:edu_platt/presentation/notification/presentation/cubit/notification_counter_cubit.dart';
import 'package:edu_platt/presentation/notification/presentation/views/notification_view.dart';
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
        BlocBuilder<NotificationCounterCubit, int>(
          builder: (context, count) {
            return Stack(
              children: [
                IconButton(
                  icon: const Icon(Icons.notifications,
                  color: Colors.grey,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      CustomPageRoute(page:  const NotificationCenterScreen()),
                    );
                  },
                ),
                if (count > 0)
                  Positioned(
                    right: 8,
                    top: 8,
                    child: CircleAvatar(
                      radius: 8,
                      backgroundColor: Colors.red,
                      child: Text(
                        '$count',
                        style: const TextStyle(fontSize: 10, color: Colors.white),
                      ),
                    ),
                  )
              ],
            );
          },
        ),
      ],
    );
  }
}
