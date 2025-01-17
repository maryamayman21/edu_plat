import 'package:edu_platt/core/utils/Assets/appAssets.dart';
import 'package:edu_platt/core/utils/Color/color.dart';
import 'package:edu_platt/presentation/Student/screen/levels/levels.dart';
import 'package:edu_platt/presentation/sharedWidget/custom_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../Routes/custom_AppRoutes.dart';

class Levels extends StatefulWidget {
  @override
  State<Levels> createState() => _LevelsState();
}

class _LevelsState extends State<Levels> with SingleTickerProviderStateMixin {
  List<levels> allLevels = levels.getLevels();
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _scaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
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
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: REdgeInsets.only(left: 25, top: 50),
              child: AnimatedBuilder(
                  animation: _controller,
                  builder: (context, child) {
                    return Transform.scale(
                      scale: _scaleAnimation.value,
                      child: child,
                    );
                  },
                  child: ShaderMask(
                    shaderCallback: (bounds) => const LinearGradient(
                      colors: [color.primaryColor, Colors.grey],
                      tileMode: TileMode.clamp,
                    ).createShader(bounds),
                    child: Text(
                      "Levels",
                      style: TextStyle(
                        fontSize: 27.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white, // اللون الافتراضي للـ text
                      ),
                    ),
                  )),
            ),
            Expanded(
              child: Padding(
                padding: REdgeInsets.only(top: 20, right: 10, left: 10),
                child: GridView.builder(
                  itemCount: allLevels.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 0.w,
                      mainAxisSpacing: 5.h),
                  itemBuilder: (context, index) {
                    return Center(
                      child: AnimatedBuilder(
                        animation: _controller,
                        builder: (context, child) {
                          return Transform.scale(
                            scale: _scaleAnimation.value,
                            child: child,
                          );
                        },
                        child: CustomContainer(
                          image: allLevels[index].image,
                          text: allLevels[index].text,
                          index: index,
                          onTap: (){
                            //Navigation to level details screen
                            //I will pass the level details in the arguments (text , leve courses)
                            Navigator.pushNamed(context, AppRouters.level1 , arguments:  allLevels[index].text);

                          },


                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ));
  }
}

class levels {
  String image;
  String text;

  levels({required this.image, required this.text});

  static List<levels> getLevels() {
    return [
      levels(image: AppAssets.level1, text: "Level 1"),
      levels(image: AppAssets.level2, text: "Level 2"),
      levels(image: AppAssets.level3, text: "Level 3"),
      levels(image: AppAssets.level4, text: "Level 4"),
    ];
  }
}



// onTap: () {
// Future.delayed(Duration.zero, () {
// if (index == 0) {
// Navigator.pushReplacement(
// context,
// PageRouteBuilder(
// pageBuilder: (context, animation,
// secondaryAnimation) =>
// const Level1(),
// transitionsBuilder: (context, animation,
// secondaryAnimation, child) {
// const begin = 0.5;
// const end = 1.0;
// const curve = Curves.easeInOut;
//
// var tween = Tween(begin: begin, end: end)
//     .chain(CurveTween(curve: curve));
// var scaleAnimation = animation.drive(tween);
//
// return ScaleTransition(
// scale: scaleAnimation, child: child);
// },
// transitionDuration:
// const Duration(milliseconds: 800),
// ),
// );
// } else if (index == 1) {
// Navigator.pushReplacement(
// context,
// PageRouteBuilder(
// pageBuilder: (context, animation,
// secondaryAnimation) =>
// const Level2(),
// transitionsBuilder: (context, animation,
// secondaryAnimation, child) {
// const begin = 0.5;
// const end = 1.0;
// const curve = Curves.easeInOut;
//
// var tween = Tween(begin: begin, end: end)
//     .chain(CurveTween(curve: curve));
// var scaleAnimation = animation.drive(tween);
//
// return ScaleTransition(
// scale: scaleAnimation, child: child);
// },
// transitionDuration:
// const Duration(milliseconds: 800),
// ),
// );
// } else if (index == 2) {
// Navigator.pushReplacement(
// context,
// PageRouteBuilder(
// pageBuilder: (context, animation,
// secondaryAnimation) =>
// const Level3(),
// transitionsBuilder: (context, animation,
// secondaryAnimation, child) {
// const begin = 0.5;
// const end = 1.0;
// const curve = Curves.easeInOut;
//
// var tween = Tween(begin: begin, end: end)
//     .chain(CurveTween(curve: curve));
// var scaleAnimation = animation.drive(tween);
//
// return ScaleTransition(
// scale: scaleAnimation, child: child);
// },
// transitionDuration:
// const Duration(milliseconds: 800),
// ),
// );
// } else if (index == 3) {
// Navigator.pushReplacement(
// context,
// PageRouteBuilder(
// pageBuilder: (context, animation,
// secondaryAnimation) =>
// const Level4(),
// transitionsBuilder: (context, animation,
// secondaryAnimation, child) {
// const begin = 0.5;
// const end = 1.0;
// const curve = Curves.easeInOut;
//
// var tween = Tween(begin: begin, end: end)
//     .chain(CurveTween(curve: curve));
// var scaleAnimation = animation.drive(tween);
//
// return ScaleTransition(
// scale: scaleAnimation, child: child);
// },
// transitionDuration:
// const Duration(milliseconds: 800),
// ),
// );
//}