import 'package:edu_platt/core/utils/Assets/appAssets.dart';
import 'package:edu_platt/core/utils/Color/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../Routes/custom_AppRoutes.dart';

class StudentOrDoctor extends StatefulWidget {
  const StudentOrDoctor({super.key});

  @override
  State<StudentOrDoctor> createState() => _StudentOrDoctorState();
}

class _StudentOrDoctorState extends State<StudentOrDoctor>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _opacityAnimation;
  late Animation<Offset> _slideAnimationButton1;
  late Animation<Offset> _slideAnimationButton2;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _slideAnimationButton1 = Tween<Offset>(
      begin: const Offset(-1, 0), // From left
      end: const Offset(0, 0), // To position
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _slideAnimationButton2 = Tween<Offset>(
      begin: const Offset(1, 0), // From right
      end: const Offset(0, 0), // To position
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, -1),
      end: const Offset(0, 0),
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SlideTransition(
            position: _slideAnimation,
            child: FadeTransition(
              opacity: _opacityAnimation,
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
            ),
          ),
          SizedBox(height: 100.h),
          Padding(
            padding: REdgeInsets.all(20.0),
            child: SlideTransition(
              position: _slideAnimationButton1,
              child: FadeTransition(
                opacity: _opacityAnimation,
                child: ElevatedButton(
                    onPressed: () {
                      //Navigate to register screen
                      Navigator.pushNamed(
                          context, AppRouters.registerRoute);
                    },
                    style: ElevatedButton.styleFrom(
                      elevation: 10,
                      shadowColor: Colors.black.withOpacity(1),
                      minimumSize: Size(100.w, 130.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10).r,
                      ),
                    ),
                    child: Text("Student",
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium
                            ?.copyWith(
                          color: color.primaryColor,
                          shadows: [
                            Shadow(
                              color: Colors.grey.withOpacity(1),
                              // Shadow color
                              offset: const Offset(2, 2),
                              // Position of the shadow
                              blurRadius: 10.r, // How blurry the shadow is
                            ),
                          ],
                        ))),
              ),
            ),
          ),
          SizedBox(
            height: 30.h,
          ),
          Padding(
            padding: REdgeInsets.all(20.0),
            child: SlideTransition(
              position: _slideAnimationButton2,
              child: FadeTransition(
                opacity: _opacityAnimation,
                child: ElevatedButton(
                    onPressed: () {
                      //Navigate to login
                      Navigator.pushNamed(
                          context, AppRouters.loginStudentRoute , arguments: true);
                    },
                    style: ElevatedButton.styleFrom(
                      elevation: 10,
                      shadowColor: Colors.black.withOpacity(1),
                      minimumSize: Size(100.w, 130.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10).r,
                      ),
                    ),
                    child: Text("Doctor",
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium
                            ?.copyWith(
                          color: color.primaryColor,
                          shadows: [
                            Shadow(
                              color: Colors.grey.withOpacity(1),
                              // Shadow color
                              offset: const Offset(2, 2),
                              // Position of the shadow
                              blurRadius: 10.r, // How blurry the shadow is
                            ),
                          ],
                        ))),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
