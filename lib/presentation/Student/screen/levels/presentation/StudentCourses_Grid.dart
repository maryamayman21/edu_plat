import 'package:edu_platt/core/utils/customDialogs/custom_dialog.dart';
import 'package:edu_platt/core/utils/helper_methds/navigation_helper.dart';
import 'package:edu_platt/presentation/Doctor/features/courses/presentation/widgets/custom_course_item.dart';
import 'package:edu_platt/presentation/Routes/custom_AppRoutes.dart';
import 'package:edu_platt/presentation/Student/screen/levels/cubit/Studentcourses_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StudentCoursesGrid extends StatelessWidget {
  const StudentCoursesGrid({super.key, required this.viewAll, required this.finalCourses,});
final bool viewAll;
final List<Map<String, dynamic>>finalCourses;
  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: 24 ),
      child: Column(
        children: [
          viewAll ? Container() : const SizedBox.shrink(),
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
                      page:AppRouters.doctorCoursesScreen,
                      context: context,
                      argument: finalCourses[index]
                  );
                },
                onDelete: () async {
                  final coursesCubit = context.read<
                      StudentCoursesCubit>();
                  bool? result = await CustomDialogs
                      .showDeletionDialog(
                    context: context,
                    title: "Confirm Action",
                    content:
                    "Are you sure you want to delete ${finalCourses[index]['courseCode']} ?",
                  );
                  if (result != null && result) {
                    await coursesCubit.deleteCachedCourse(
                        finalCourses[index]['courseCode'] , finalCourses);

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
