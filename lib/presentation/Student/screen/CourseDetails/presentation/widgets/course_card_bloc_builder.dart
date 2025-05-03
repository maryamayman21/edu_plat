import 'package:edu_platt/presentation/Student/screen/CourseDetails/domain/entity/course_card_entity.dart';
import 'package:edu_platt/presentation/Student/screen/CourseDetails/presentation/cubit/course_card_cubit.dart';
import 'package:edu_platt/presentation/Student/screen/CourseDetails/presentation/widgets/card_shimmer_effect.dart';
import 'package:edu_platt/presentation/Student/screen/CourseDetails/presentation/widgets/course_details_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class CourseCardBlocBuilder extends StatelessWidget {
  final String courseCode;
  const CourseCardBlocBuilder({super.key, required this.courseCode});

  @override
  Widget build(BuildContext context) {
    return   BlocBuilder<CourseCardCubit, CourseCardState>(
      builder: (context, state) {
        if(state is CourseCardLoading){
          return  const CardShimmerEffect();
        }
        if(state is CourseCardSuccess) {
          final CourseCardEntity courseCardEntity = state.courseCardEntity;
          return Padding(
            padding: REdgeInsets.symmetric(horizontal: 16.0.w),
            child:
            ///TODO::REFACTOR CARD PARAMETERS
            CourseDetailsCard(
                courseTitle: courseCardEntity.courseDescription,
                creditHours:courseCardEntity.creditHours,
                lectures: courseCardEntity.noOfLectures,
                doctorName: courseCardEntity.doctorName,
                marks:courseCardEntity.grading, courseCode: courseCode,

            ),
          );
        }
        if(state is CourseCardFailure){
          return Text(state.errorMessage);
        }
        return Text('Something went wrong');
      },
    );
  }
}
