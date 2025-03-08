
import 'package:edu_platt/core/network/api_service.dart';
import 'package:edu_platt/core/network/internet_connection_service.dart';
import 'package:edu_platt/presentation/Doctor/features/course_details/cubit/tab_index_cubit.dart';
import 'package:edu_platt/presentation/Student/screen/CourseDetails/data/data_source/remote_data_source.dart';
import 'package:edu_platt/presentation/Student/screen/CourseDetails/data/repo/course_details_imp.dart';
import 'package:edu_platt/presentation/Student/screen/CourseDetails/presentation/cubit/course_card_cubit.dart';
import 'package:edu_platt/presentation/Student/screen/CourseDetails/presentation/cubit/course_files_cubit.dart';
import 'package:edu_platt/presentation/Student/screen/CourseDetails/presentation/widgets/Widget_Course_header.dart';
import 'package:edu_platt/presentation/Student/screen/CourseDetails/presentation/widgets/course_card_bloc_builder.dart';
import 'package:edu_platt/presentation/Student/screen/CourseDetails/presentation/widgets/course_files_bloc_builder.dart';
import 'package:edu_platt/presentation/Student/screen/CourseDetails/presentation/widgets/tabs_bloc_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class Coursedetails extends StatefulWidget {
  const Coursedetails({super.key, required this.courseCode, required this.doctorId});
  final String courseCode;
  final String doctorId;
  @override
  State<Coursedetails> createState() => _CoursedetailsState();
}

class _CoursedetailsState extends State<Coursedetails> {

  @override
  Widget build(BuildContext context) {
    return  MultiBlocProvider(
      providers: [
        BlocProvider<IndexCubit>(
          create: (context) => IndexCubit(),
        ),
        ///TODO::ADD DOCTOR ID
        BlocProvider<CourseFilesCubit>(
          create: (context) => CourseFilesCubit(
          courseDetailsRepo: CourseDetailsRepoImp(CourseDetailsRemoteDataSourceImpl(ApiService()) , NetworkInfoImpl(InternetConnectionChecker.instance) ) ,
            courseCode: widget.courseCode,
            indexCubit: context.read<IndexCubit>(),
            doctorId: widget.doctorId
          )
        ),
        BlocProvider<CourseCardCubit>(
          create: (context) => CourseCardCubit(
            courseDetailsRepo: CourseDetailsRepoImp(CourseDetailsRemoteDataSourceImpl(ApiService()) , NetworkInfoImpl(InternetConnectionChecker.instance) ) ,
          )..fetchCourseCard(widget.courseCode, widget.doctorId)
        )
      ],
      child: Scaffold(
          body: CustomScrollView(
              slivers: [
                // Header
                 WidgetCourseHeader(
                    courseCode:widget.courseCode),
                SliverToBoxAdapter(child: SizedBox(height: 15.h)),
             //
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
                const CourseCardBlocBuilder(),
                SliverToBoxAdapter(child: SizedBox(height: 20.h)),

                const TabsBlocBuilder(),

                //material files
                const CourseFilesBlocBuilder(),
                
              ]
          )
      ),
    );
  }
}



