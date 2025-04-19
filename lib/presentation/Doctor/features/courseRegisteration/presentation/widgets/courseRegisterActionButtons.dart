import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/utils/Assets/appAssets.dart';
import '../../../../../../core/utils/Color/color.dart';
import '../../../../../../core/utils/customDialogs/custom_dialog.dart';
import '../../../../../Routes/custom_AppRoutes.dart';
import '../../../../../sharedWidget/buttons/action_button.dart';
import '../../application/cubit/course_registeration_cubit.dart';
import '../../application/cubit/dropdown_cubit.dart';
import '../../application/cubit/dropdown_state.dart';

class CourseRegisterationActionButtons extends StatelessWidget {
  const CourseRegisterationActionButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DropdownCubit, DropdownState>(builder: (context, state) {
      final hasSelectedCourses =
      state.selectedCourses.values.any((list) => list.isNotEmpty);
      return Container(
          height: 90,
          decoration: const BoxDecoration(
            // color: Colors.grey.withOpacity(0.3),
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(15), topLeft: Radius.circular(15))),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child:
            BlocListener<CourseRegisterationCubit, CourseRegisterationState>(
                listener: (context, state) {
                  // TODO: implement listener
                  if (state is CoursesRegistered) {
                    print(state.message);
                    Navigator.pushReplacementNamed(context,
                        AppRouters.doctorCoursesRegisterSuccessRoute);
                  }
                  else if (state is CourseRegisterationFailure) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content: Text('${state.errorMessage}')));
                  }
                },
                child:
                BlocBuilder<CourseRegisterationCubit, CourseRegisterationState>(
                  builder: (context, state) {
                   if( state is CourseRegisterationFailure ||
                        state is CourseRegisterationLoading )  {return const SizedBox.shrink(); }
                   else if(state is CourseRegisterationSuccess) {
                     print('Successssssss');
                     return  Row(
                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                       children: [
                         ActionButton(
                             text: 'Cancel',
                             onPressed: hasSelectedCourses
                                 ? () {
                               context.read<DropdownCubit>()
                                   .clearAllSelections();
                               ScaffoldMessenger.of(context).showSnackBar(
                                 const SnackBar(
                                     content: Text('Selections Cleared!')),
                               );
                             }
                                 : null,
                             backgroundColor:
                             hasSelectedCourses ? Colors.white : Colors.grey,
                             foregroundColor: color.primaryColor),
                         ActionButton(
                           text: 'Register',
                           onPressed: hasSelectedCourses
                               ? () async {
                             final selectedCourses = context
                                 .read<DropdownCubit>()
                                 .getAllSelectedCourses();

                             if (selectedCourses.isNotEmpty) {
                               final selectedDetails = selectedCourses.entries
                                   .map((entry) =>
                               " ${entry.key}, Selected Courses: ${entry.value
                                   .join(
                                   ", ")}")
                                   .join("\n");
                               List<String> registerCourses = selectedCourses
                                   .values.expand((list) => list).toList();
                               bool? isRegistered =
                               await CustomDialogs.showConfirmationDialog(
                                   context: context,
                                   title: 'Course Registration',
                                   content: selectedDetails,
                                   imageUrl: AppAssets.books);

                               if (isRegistered != null && isRegistered) {
                                 context
                                     .read<CourseRegisterationCubit>()
                                     .registerCourses(registerCourses);
                               }
                             }
                           }
                               : null,
                           backgroundColor: hasSelectedCourses
                               ? color.primaryColor
                               : Colors.grey, // Red background
                           foregroundColor: Colors.white,
                         ),

                       ],
                     );
                   }
                    return const SizedBox.shrink();

                  },
                )

            ),

          )
      );
    }
    )
    ;
  }
}
