
import 'package:edu_platt/core/utils/Assets/appAssets.dart';
import 'package:edu_platt/core/utils/Color/color.dart';
import 'package:edu_platt/core/utils/Strings/string.dart';
import 'package:edu_platt/presentation/onBoarding/onboardingNavigator.dart';
import 'package:edu_platt/presentation/onBoarding/onboardingPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class onboarding extends StatefulWidget {
  const onboarding({super.key});

  @override
  State<onboarding> createState() => _onboardingState();
}

class _onboardingState extends State<onboarding> {
  PageController pageController = PageController();
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView(
              controller: pageController,
              onPageChanged: (index) {
                setState(() {
                  currentIndex = index;
                });
              },
              children: [
                onBoardingBage(
                  image: AppAssets.onboarding1,
                  text: Strings.onboarding1,
                ).animate().fadeIn(duration: 800.ms),
                onBoardingBage(
                  image: AppAssets.onboarding2,
                  text: Strings.onboarding2,
                ).animate().fadeIn(duration: 800.ms),
                onBoardingBage(
                  image: AppAssets.onboarding3,
                  text: Strings.onboarding3,
                ).animate().fadeIn(duration: 800.ms),
              ],
            ),
          ),
          SmoothPageIndicator(
            controller: pageController,
            count: 3,
            effect: ExpandingDotsEffect(
              dotColor: Colors.grey,
              activeDotColor: color.primaryColor,
              dotHeight: 10.h,
              dotWidth: 10.w,
            ),
          ),
          SizedBox(
            height: 100.h,
          ),
          Onboardingnavigator(
            pageController: pageController,
            currentIndex: currentIndex,
          ),
        ],
      ),
    );
  }
}
