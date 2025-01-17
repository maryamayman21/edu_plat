import 'dart:ui';

import 'package:flutter/material.dart';

import '../../../../../../core/utils/Assets/appAssets.dart';
import '../../../../../../core/utils/Color/color.dart';

class CustomCourseItem extends StatelessWidget {
  const CustomCourseItem({
    super.key,
    required this.courseCode,
    required this.onDelete,
    required this.onTap,
    this.showDeleteIcon = true,
  });

  final String courseCode;
  final void Function()? onDelete;
  final void Function()? onTap;
  final bool showDeleteIcon;

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Positioned(
        top: 0,
        left: 0,
        right: 0,
        bottom: 0,
        child: Hero(
          tag: courseCode,
          child: Container(
            width: 200,
            height: 150,
            decoration: BoxDecoration(
              image: const DecorationImage(
                  image: AssetImage(
                    AppAssets.courseBackground,
                  ),
                  fit: BoxFit.fill),
              boxShadow: [
                BoxShadow(
                  color: color.primaryColor.withOpacity(0.4), // Shadow color
                //  spreadRadius: 2, // Spread radius
                  blurRadius: 7, // Blur radius
                  offset:
                      const Offset(0, 10), // Shadow position (horizontal, vertical)
                ),
              ],
              borderRadius: const BorderRadius.all(Radius.circular(30)),
            ),
            child: Center(
              child: Text(courseCode,
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      letterSpacing: 1,
                      fontFamily: 'Roboto-Mono',
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold)),
            ),
          ),
        ),
      ),
      if (showDeleteIcon)
        Positioned(
          right: 1,
          top: 1,
          child: IconButton(
              onPressed: onDelete,
              icon: const Icon(
                Icons.delete,
                color: Colors.white70,
                size: 24,
              )),
        ),
      Positioned(
        bottom: 25,
        left: 15,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 40, sigmaY: 40),
            child: InkWell(
              //Navigation to course details
              onTap: onTap,
              child: Container(
                height: 30,
                width: 140,
                decoration: const BoxDecoration(
                  //color:  Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(60)),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(width: 1),
                    Text(
                      'View Course',style:TextStyle(color: Color(0xffE6E6E6)),
                    ),
                    Icon(
                      Icons.arrow_circle_right_rounded,
                      color: Colors.white,
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      )
    ]);
  }
}
