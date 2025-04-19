import 'package:edu_platt/presentation/Doctor/features/courseRegisteration/data/models/course.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../application/cubit/dropdown_cubit.dart';
import '../../application/cubit/dropdown_state.dart';

import 'course_item.dart';

class DropdownList extends StatelessWidget {
  final String id; // Unique identifier for the dropdown
  final List<Course> courses;

  const DropdownList({Key? key, required this.id, required this.courses})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DropdownCubit, DropdownState>(
        builder: (context, state) {
        return AnimatedSize(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeIn,
          child: state.isExpanded[id] == true
              ? GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 2,
                    mainAxisSpacing: 15,
                    crossAxisSpacing: 15,
                  ),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: courses.length,
                  itemBuilder: (context, index) {
                    return CourseItem(
                      courseCode: courses[index].courseCode,
                      isSelected:
                          ///////////////////////////////////
                          state.selectedCourses[id]?.contains(courses[index].courseCode) ??
                              false,
                      onSelect: () =>
                      /////////////////////////////////////////////////////////
                          context.read<DropdownCubit>().selectCourse(id,  courses[index].courseCode),
                    );
                  },
                )
              : const SizedBox.shrink(),
        );

    });
  }
}
