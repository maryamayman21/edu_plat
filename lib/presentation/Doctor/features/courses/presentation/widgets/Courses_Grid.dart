import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/utils/customDialogs/custom_dialog.dart';
import '../../../../../../core/utils/helper_methds/navigation_helper.dart';
import '../../../home/presentation/widgets/search_bar.dart';
import '../../application/cubit/courses_cubit.dart';
import 'custom_course_item.dart';
class CoursesGrid extends StatelessWidget {
  const CoursesGrid({super.key, required this.viewAll, this.finalCourses, required this.page});
final bool viewAll;
final finalCourses;
  final String page;
  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: 24, vertical: 8),
      child: Column(
        children: [
          viewAll ? const CustomSearchBar() : const SizedBox
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
                      context, page, finalCourses[index]);
                },
                onDelete: () async {
                  final coursesCubit = context.read<
                      CoursesCubit>();
                  bool? result = await CustomDialogs
                      .showDeletionDialog(
                    context: context,
                    title: "Confirm Action",
                    content:
                    "Are you sure you want to delete ${finalCourses[index]} ?",
                  );
                  if (result != null && result) {
                    /////////////////////////////////TESTTTTTTTTTT
                    await coursesCubit.deleteCachedCourse(
                        finalCourses[index] , finalCourses);

                  }
                },
                courseCode: finalCourses[index],

              );

              // return
            },
          ),
        ],
      ),
    );
  }
}