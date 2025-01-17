
import 'package:edu_platt/core/utils/Color/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../Routes/custom_AppRoutes.dart';

class Onboardingnavigator extends StatelessWidget {
  PageController pageController;
  int currentIndex;

  Onboardingnavigator(
      {required this.pageController, required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: REdgeInsets.only(left: 20, right: 20, bottom: 50),
      child: Row(
        mainAxisAlignment: currentIndex == 2
            ? MainAxisAlignment.center // Align to center when it's the 3rd page
            : MainAxisAlignment.spaceBetween, // Otherwise space between
        children: [
          if (currentIndex < 2)
            ElevatedButton(
              onPressed: () {
                pageController.animateToPage(
                  2,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                );
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 15.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25).r,
                ),
              ),
              child: Text("Skip",
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall
                      ?.copyWith(color: color.primaryColor)),
            ),
          if (currentIndex == 2)
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacementNamed(
                    context, AppRouters.studentOrDoctor);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: color.primaryColor,
                padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 15.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25).r,
                ),
              ),
              child: Text(
                "Get Started",
                style: Theme.of(context)
                    .textTheme
                    .titleSmall
                    ?.copyWith(color: Colors.white),
              ),
            ),
          if (currentIndex < 2)
            ElevatedButton(
              onPressed: () {
                pageController.nextPage(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: color.primaryColor,
                padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 15.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25).r,
                ),
              ),
              child: Text(
                "Next",
                style: Theme.of(context)
                    .textTheme
                    .titleSmall
                    ?.copyWith(color: Colors.white),
              ),
            ),
        ],
      ),
    );
  }
}
