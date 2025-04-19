import 'package:edu_platt/presentation/Routes/custom_AppRoutes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../core/utils/Assets/appAssets.dart';
import '../../../home/presentation/widgets/custom_appbar.dart';
import '../../../home/application/app_bar_cubit.dart';
import '../../../home/presentation/widgets/doctor_drawer.dart';

import '../widgets/courses_listView.dart';
class CoursesScreen extends StatefulWidget {
  const CoursesScreen({super.key});

  @override
  State<CoursesScreen> createState() => _CoursesScreenState();
}

class _CoursesScreenState extends State<CoursesScreen>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
    create:  (context) => AppBarCubit()..initAnimation(this),
      child: Scaffold(
          drawer: const DoctorDrawer(),
          appBar: CustomAppbar(),
          body: SingleChildScrollView(
        child: Column(
          children: [

            SizedBox(height: 15.h),

            Container(
              height: 200,
              width: 400,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(AppAssets.doctorImage), fit: BoxFit.fill)),
            ),

            //course

            Padding(
              padding: const EdgeInsets.symmetric( horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Courses',
                    style: Theme.of(context)
                        .textTheme
                        .headlineLarge!
                        .copyWith(fontSize: 22,
                     fontFamily: 'Roboto-Mono'
                    ),
                  ),
                  TextButton(
                      onPressed: () {
                         //Navigation to view all screen
                        Navigator.pushNamed(context, AppRouters.doctorViewAllCoursesRoute);

                  }, child: const Text('View all'))
                ],
              ),
            ),

            CoursesListview( page: AppRouters.doctorCourseDetailsRoute,)
          ],
        ),
      )),
    );
  }
}
