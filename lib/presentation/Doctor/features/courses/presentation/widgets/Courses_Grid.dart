import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/utils/customDialogs/custom_dialog.dart';
import '../../../../../../core/utils/helper_methds/navigation_helper.dart';
import '../../application/cubit/courses_cubit.dart';
import 'custom_course_item.dart';
class CoursesGrid extends StatelessWidget {
  const CoursesGrid({super.key, required this.viewAll, required this.finalCourses, required this.page});
final bool viewAll;
final List<Map<String, dynamic>> finalCourses;
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
            itemCount: finalCourses.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return CustomCourseItem(
                onTap: () {
                  selectedCourse(
                    page: page,
                      context: context,
                      argument: finalCourses[index]['courseCode']
                  );
                },
                onDelete: () async {
                  final coursesCubit = context.read<
                      CoursesCubit>();
                  bool? result = await CustomDialogs
                      .showDeletionDialog(
                    context: context,
                    title: "Confirm Action",
                    content:
                    "Are you sure you want to delete ${finalCourses[index]['courseCode']} ?",
                  );
                  if (result != null && result) {
                    await coursesCubit.deleteCachedCourse(
                        finalCourses[index]['CourseCode'] , finalCourses);

                  }
                },
                courseCode: finalCourses[index]['courseCode'],

              );

              // return
            },
          ),
        ],
      ),
    );
  }
}
