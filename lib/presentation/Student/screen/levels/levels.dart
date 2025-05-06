import 'package:edu_platt/core/utils/Color/color.dart';
import 'package:edu_platt/presentation/Doctor/features/home/application/app_bar_cubit.dart';
import 'package:edu_platt/presentation/Student/screen/levels/presentation/Studentcourses_listView.dart';
import 'package:edu_platt/presentation/Student/screen/levels/widgets/level_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../Routes/custom_AppRoutes.dart';
class Levels extends StatefulWidget {
  @override
  State<Levels> createState() => _LevelsState();
}

class _LevelsState extends State<Levels> with TickerProviderStateMixin {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:  BlocProvider(
          create:  (context) => AppBarCubit()..initAnimation(this),
            child: SingleChildScrollView(
                  child: Padding(
                    padding: REdgeInsets.only(top: 40.0),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 240.h,
                          width: 400.w,
                          child: const LevelWidget(),
                        ),
                        SizedBox(height: 25.h,),
                        Padding(
                          padding: const EdgeInsets.symmetric( horizontal: 30,vertical: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ShaderMask(
                                shaderCallback: (bounds) => const LinearGradient(
                                  colors: [color.primaryColor, Colors.grey],
                                  tileMode: TileMode.clamp,
                                ).createShader(bounds),
                                child: const Text(
                                  'Courses',
                                  style: TextStyle(fontSize: 28,color: Colors.white,fontWeight: FontWeight.bold
                                  ),
                                ),
                              ),
                              TextButton(
                                  onPressed: () {
                                    //Navigation to view all screen
                                    Navigator.pushNamed(context, AppRouters.studentViewAllCoursesRoute);

                                    }, child: const Text('View all'))
                            ],
                          ),
                        ),
                         StudentCoursesListview()
                      ],
                    ),
                  ),
                ),
          ));
  }
}




