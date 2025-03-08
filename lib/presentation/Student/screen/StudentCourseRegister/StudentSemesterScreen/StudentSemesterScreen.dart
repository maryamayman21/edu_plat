import 'package:edu_platt/core/utils/Assets/appAssets.dart';
import 'package:edu_platt/core/utils/Color/color.dart';
import 'package:edu_platt/presentation/Routes/custom_AppRoutes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';



class StudentSemesterscreen extends StatefulWidget {
  const StudentSemesterscreen({super.key});

  @override
  State<StudentSemesterscreen> createState() => _StudentSemesterscreenState();
}

class _StudentSemesterscreenState extends State<StudentSemesterscreen>
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
      appBar: AppBar(),
      body: SingleChildScrollView(
        child:
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SlideTransition(
              position: _slideAnimation,
              child: FadeTransition(
                opacity: _opacityAnimation,
                child: Container(
                  height: 230.h,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      image: const DecorationImage(
                        image: AssetImage(AppAssets.doctorImage),
                        fit: BoxFit.fill,
                        // colorFilter: ColorFilter.mode(
                        //   Colors.white.withOpacity(0.7), //
                        //   BlendMode.dstATop, //
                        // ),
                      ),
                      borderRadius: BorderRadius.only(
                          bottomRight: const Radius.circular(10).r,
                          bottomLeft: const Radius.circular(10).r)),
                ),
              ),
            ),
            const SizedBox(
              height: 64,
            ),
            SlideTransition(
              position: _slideAnimationButton1,
              child: FadeTransition(
                opacity: _opacityAnimation,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child:  ElevatedButton(
                      onPressed: () {
                        //Navigate to register screen
                        Navigator.pushNamed(context, AppRouters.studentCourseRegisterationRoute, arguments: 1);
                      },
                      style: ElevatedButton.styleFrom(
                        elevation: 10,
                        shadowColor: Colors.black.withOpacity(1),
                        minimumSize: Size(100.w, 130.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10).r,
                        ),
                      ),
                      child: Text("First Semester",
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium
                              ?.copyWith(
                            color: color.primaryColor,
                            fontFamily: 'Roboto-Mono',
                            shadows: [
                              Shadow(
                                color: Colors.grey.withOpacity(1),
                                // Shadow color
                                offset: const Offset(2, 2),
                                // Position of the shadow
                                blurRadius:
                                10.r, // How blurry the shadow is
                              ),
                            ],
                          ))
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 64.h,
            ),
            SlideTransition(
              position: _slideAnimationButton2,
              child: FadeTransition(
                opacity: _opacityAnimation,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child:  ElevatedButton(
                      onPressed: () {
                        //Navigate to register screen
                        Navigator.pushNamed(context, AppRouters.studentCourseRegisterationRoute, arguments: 2);
                      },
                      style: ElevatedButton.styleFrom(
                        elevation: 10,
                        shadowColor: Colors.black.withOpacity(1),
                        minimumSize: Size(100.w, 130.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10).r,
                        ),
                      ),
                      child: Text("Second Semester",
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium
                              ?.copyWith(
                            color: color.primaryColor,
                            fontFamily: 'Roboto-Mono',
                            shadows: [
                              Shadow(
                                color: Colors.grey.withOpacity(1),
                                // Shadow color
                                offset: const Offset(2, 2),
                                // Position of the shadow
                                blurRadius:
                                10.r, // How blurry the shadow is
                              ),
                            ],
                          ))
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
