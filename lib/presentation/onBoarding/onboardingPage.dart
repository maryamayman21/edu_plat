import 'package:edu_platt/core/utils/Color/color.dart';
import 'package:edu_platt/core/utils/Strings/string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class onBoardingBage extends StatelessWidget {
  String image;
  String text;

  onBoardingBage({required this.image, required this.text});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          image,
          width: double.infinity,
        ),
        Text(
          Strings.onboardingHeader1,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: color.primaryColor,
              fontSize: 26.sp),
          textAlign: TextAlign.center,
        ),
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: Text(
            text,
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(fontSize: 20.sp, fontWeight: FontWeight.w400),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
