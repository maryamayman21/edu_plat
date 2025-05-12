import 'package:edu_platt/core/utils/Assets/appAssets.dart';
import 'package:edu_platt/core/utils/Color/color.dart';
import 'package:edu_platt/presentation/Routes/custom_AppRoutes.dart';
import 'package:edu_platt/presentation/sharedWidget/buttons/custom_button.dart';
import 'package:flutter/material.dart';
class NoCoursesFoundWidget extends StatelessWidget {
  const NoCoursesFoundWidget({super.key, required this.semesterRoute});
  final String semesterRoute;
  @override
  Widget build(BuildContext context) {
    return   Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Image.asset(AppAssets.books),
        const Text(
          'No courses yet.',
          style: TextStyle(
            color: color.primaryColor,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: CustomButtonWidget(
            onPressed: () {
              Navigator.pushNamed(context, semesterRoute);
            },
            child: const Text(
              'Register Courses',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
