import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/utils/Assets/appAssets.dart';
import '../../application/app_bar_cubit.dart';

class SliverCustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  final Size preferredSize;

  SliverCustomAppBar({Key? key})
      : preferredSize = Size.fromHeight(130.0),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return  SliverAppBar(
      backgroundColor:Colors.transparent,
      expandedHeight: 100, // Height when expanded
      floating: false, // Doesn't float above content
      pinned: true, // Stays pinned at the top when collapsed
      actions: [
        Padding(
          padding: REdgeInsets.only(right: 10),
          child: Icon(
            Icons.notifications_active,
            color: Colors.black,
            size: 30.r,
          ),
        ),
      ],
      flexibleSpace: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          // Calculate the app bar's opacity based on its height
          final double appBarHeight = constraints.biggest.height;
          final double fadePoint = 100; // Expanded height
          final double opacity = (appBarHeight / fadePoint).clamp(0.0, 1.0);

          return FlexibleSpaceBar(
            title:  ScaleTransition(
                scale:  context.watch<AppBarCubit>().state,
                child: Image.asset(
                  AppAssets.logo,
                  height: 70,
                  width: 80,
                )),
            centerTitle: true,


          );
        },
      ),
    );
  }
}
