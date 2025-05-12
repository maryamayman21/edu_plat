import 'package:edu_platt/core/utils/customDialogs/custom_dialog.dart';
import 'package:edu_platt/core/utils/helper_methds/navigation_helper.dart';
import 'package:edu_platt/presentation/Doctor/features/courses/presentation/widgets/custom_course_item.dart';
import 'package:edu_platt/presentation/courses/domain/entity/course_entity.dart';
import 'package:edu_platt/presentation/courses/presentaion/cubit/courses_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class CoursesGrid extends StatelessWidget {
  const CoursesGrid({super.key, this.viewAll = false, required this.courses, required this.page});
  final bool viewAll;
  final List<CourseEntity> courses;
  final String page;
  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: 24, vertical: 8),
      child: Column(
        children: [
          viewAll ? const SizedBox
              .shrink(): const SizedBox
              .shrink(),
          const SizedBox(height: 30,),
          GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 8 / 7,
                mainAxisSpacing: 20,
                crossAxisSpacing: 10
            ),
            physics: const NeverScrollableScrollPhysics(),
            itemCount: courses.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {

                  return CustomCourseItem(
                    onTap: () {
                      selectedCourse(
                          page: page,
                          context: context,
                          argument: courses[index]
                      );
                    },
                    onDelete: () async {
                      final coursesCubit = BlocProvider.of<CoursesCubit>(context);
                      bool? result = await CustomDialogs
                          .showDeletionDialog(
                        context: context,
                        title: "Confirm Action",
                        content:
                        "Are you sure you want to delete ${courses[index].courseCode} ?",
                      );
                      if (result != null && result) {
                        await coursesCubit.deleteCourse(courses[index].courseCode);
                      }
                    },
                    courseCode: courses[index].courseCode,
                  );
                }
          ),
        ],
      ),
    );
  }
}
