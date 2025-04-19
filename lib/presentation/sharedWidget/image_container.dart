import 'package:edu_platt/core/utils/Assets/appAssets.dart';
import 'package:edu_platt/core/utils/Color/color.dart';
import 'package:edu_platt/presentation/sharedWidget/animated_widegt.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class ImageContainer extends StatefulWidget {
  const ImageContainer({super.key});

  @override
  State<ImageContainer> createState() => _ImageContainerState();
}

class _ImageContainerState extends State<ImageContainer> with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return  AnimatedContainerWidget(
      vsync: this,
      startOffset: const Offset(-1, 0),
      child: Container(
        height: 230.h,
        decoration: BoxDecoration(
            color: color.primaryColor,
            image: DecorationImage(
              image: const AssetImage(AppAssets.image),
              fit: BoxFit.fitHeight,
              colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.7), //
                BlendMode.dstATop, //
              ),
            ),
            borderRadius: BorderRadius.only(
                bottomRight: const Radius.circular(10).r,
                bottomLeft: const Radius.circular(10).r)),
      ),
    );
  }
}
