import 'package:edu_platt/core/network/api_service.dart';
import 'package:edu_platt/core/network/internet_connection_service.dart';
import 'package:edu_platt/presentation/Student/screen/CourseDetails/data/data_source/remote_data_source.dart';
import 'package:edu_platt/presentation/Student/screen/CourseDetails/data/repo/course_details_imp.dart';
import 'package:edu_platt/presentation/Student/screen/CourseDetails/domain/entity/doctor_courses_entity.dart';
import 'package:edu_platt/presentation/Student/screen/CourseDetails/presentation/cubit/doctor_courses_cubit.dart';
import 'package:edu_platt/presentation/Student/screen/CourseDetails/presentation/widgets/doctor_courses.dart';
import 'package:edu_platt/presentation/courses/domain/entity/course_entity.dart';
import 'package:edu_platt/presentation/sharedWidget/image_container.dart';
import 'package:edu_platt/presentation/sharedWidget/no_wifi_widget.dart';
import 'package:edu_platt/presentation/sharedWidget/text_error.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';


class DoctorCoursesScreen extends StatefulWidget {
  const DoctorCoursesScreen({super.key, required this.courseDetail});

  final CourseEntity courseDetail;

  @override
  State<DoctorCoursesScreen> createState() => _DoctorCoursesState();
}

class _DoctorCoursesState extends State<DoctorCoursesScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DoctorCoursesCubit(courseDetailsRepo: CourseDetailsRepoImp(CourseDetailsRemoteDataSourceImpl(ApiService()) , NetworkInfoImpl(InternetConnectionChecker()) ))..fetchDoctorCourses(widget.courseDetail.courseCode),
      child: Scaffold(
          appBar: AppBar(),
          body: BlocBuilder<DoctorCoursesCubit, DoctorCoursesState>(
              builder: (context, state) {
            if (state is DoctorCoursesSuccess) {
              final List<DoctorCoursesEntity> doctorCourses = state.doctorCoursesEntity;
              return
                Column(
                  children: [
                    const ImageContainer(),
                     doctorCourses.isEmpty? Align(
                         alignment: Alignment.center,
                         child: Text( 'No doctor has registered ${widget.courseDetail.courseCode} yet')): Expanded(
                      child: ListView.builder(
                        itemBuilder: (context, index) {
                         return   DoctorCoursesWidget(
                           doctorCoursesEntity: doctorCourses[index],
                           courseDetail: widget.courseDetail,
                         ) ;
                        },
                      itemCount: doctorCourses.length,
                                    ),
                    ),
                  ],
                );
            }
            if (state is DoctorCoursesLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if(state is DoctorCoursesFailure) {
              if (state.errorMessage == 'No internet connection') {
                   return NoWifiWidget( onPressed: () {
                     BlocProvider.of<DoctorCoursesCubit>(context)
                         .fetchDoctorCourses(widget.courseDetail.courseCode);
                   },);
              } else {
                return Center(child: TextError(
                  errorMessage: state.errorMessage,
                  onPressed: () {
                  BlocProvider.of<DoctorCoursesCubit>(context)
                      .fetchDoctorCourses(widget.courseDetail.courseCode);
                },
                )
                );
              }
            }
            return const Center(child: CircularProgressIndicator());
          }

          )
      ),
    );
  }
}
