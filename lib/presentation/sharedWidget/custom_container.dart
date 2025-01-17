
import 'package:edu_platt/core/utils/Color/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomContainer extends StatelessWidget {
  String image;
  String text;
  int index;
  final VoidCallback onTap;

  CustomContainer(
      {required this.image,
      required this.text,
      required this.index,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onTap,
        child: Padding(
        padding: REdgeInsets.only(top: 8, left: 0, right: 0),
        child: Container(
        width: 200.r,
        height: 250.h,
        decoration: const BoxDecoration(
          color: color.primaryColor,
              borderRadius: BorderRadius.all(Radius.circular(30))),
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
              ColorFiltered(
                colorFilter: ColorFilter.mode(
                  const Color(0xff8fa2c6).withOpacity(0.5),
                  BlendMode.srcATop,
                ),
                child: Image.asset(
                  image,
                  fit: BoxFit.cover,
                  width: 80.w,
                  height: 120.h,
                ),
              ),
            const SizedBox(
              height: 20,
            ),
            Text(
              text,
              style: Theme.of(context)
                  .textTheme
                  .labelSmall?.copyWith(
                    fontSize: 23.sp,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xffE6E6E6)),
                textAlign: TextAlign.end,
            )
          ],
        ),
      ),
      ),
    );
  }
}
