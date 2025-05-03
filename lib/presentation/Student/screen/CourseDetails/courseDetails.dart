
import 'package:edu_platt/core/network/api_service.dart';
import 'package:edu_platt/core/network/internet_connection_service.dart';
import 'package:edu_platt/presentation/Student/screen/CourseDetails/data/data_source/remote_data_source.dart';
import 'package:edu_platt/presentation/Student/screen/CourseDetails/data/repo/course_details_imp.dart';
import 'package:edu_platt/presentation/Student/screen/CourseDetails/presentation/cubit/course_card_cubit.dart';
import 'package:edu_platt/presentation/Student/screen/CourseDetails/presentation/cubit/course_files_cubit.dart';
import 'package:edu_platt/presentation/Student/screen/CourseDetails/presentation/cubit/material_type_cubit.dart';
import 'package:edu_platt/presentation/Student/screen/CourseDetails/presentation/widgets/Widget_Course_header.dart';
import 'package:edu_platt/presentation/Student/screen/CourseDetails/presentation/widgets/course_card_bloc_builder.dart';
import 'package:edu_platt/presentation/Student/screen/CourseDetails/presentation/widgets/course_files_bloc_builder.dart';
import 'package:edu_platt/presentation/Student/screen/CourseDetails/presentation/widgets/tabs_bloc_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class Coursedetails extends StatefulWidget {
  const Coursedetails({super.key, required this.courseDetails, required this.doctorId});
  final Map<String, dynamic> courseDetails;
  final String doctorId;
  @override
  State<Coursedetails> createState() => _CoursedetailsState();
}

class _CoursedetailsState extends State<Coursedetails> {

  @override
  Widget build(BuildContext context) {
    return  MultiBlocProvider(
      providers: [
        BlocProvider<MaterialTypeCubit>(
          create: (context) => MaterialTypeCubit(),
        ),
        BlocProvider<CourseFilesCubit>(
          create: (context) => CourseFilesCubit(
          courseDetailsRepo: CourseDetailsRepoImp(CourseDetailsRemoteDataSourceImpl(ApiService()) , NetworkInfoImpl(InternetConnectionChecker()) ) ,
            courseCode: widget.courseDetails['courseCode'],
            materialTypeCubit: context.read<MaterialTypeCubit>(),
            doctorId: widget.doctorId
          )
        ),
        BlocProvider<CourseCardCubit>(
          create: (context) => CourseCardCubit(
            courseDetailsRepo: CourseDetailsRepoImp(CourseDetailsRemoteDataSourceImpl(ApiService()) , NetworkInfoImpl(InternetConnectionChecker()) ) ,
          )..fetchCourseCard(widget.courseDetails['courseCode'], widget.doctorId)
        )
      ],
      child: Scaffold(
          body: CustomScrollView(
              slivers: [
                // Header
                 WidgetCourseHeader(
                    courseCode:widget.courseDetails['courseCode']),
                SliverToBoxAdapter(child: SizedBox(height: 15.h)),

             //    BlocBuilder<CourseCardCubit, CourseCardState>(
             //  builder: (context, state) {
             //      return SliverToBoxAdapter(
             //        child: Padding(
             //        padding: const EdgeInsets.all(16.0),
             //        child: Text(
             //          courses[selectedIndex].courseDescription,
             //          style: TextStyle(
             //            color: color.primaryColor,
             //            fontSize: 22.sp,
             //          ),
             //        ),
             //      ),
             //    );
             // },
             //  ),
                SliverToBoxAdapter(child: CourseCardBlocBuilder(courseCode: widget.courseDetails['courseCode'] ,)),

                SliverToBoxAdapter(child: SizedBox(height: 20.h)),

                  TabsBlocBuilder(
                  hasLab: widget.courseDetails['has_Lab'],
                                  ),

                const CourseFilesBlocBuilder(),
                
              ]
          )
      ),
    );
  }
}



