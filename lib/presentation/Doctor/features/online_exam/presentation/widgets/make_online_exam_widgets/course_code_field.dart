import 'package:edu_platt/presentation/Doctor/features/online_exam/presentation/bloc/online_exam_bloc.dart';
import 'package:edu_platt/presentation/Doctor/features/online_exam/presentation/widgets/make_online_exam_widgets/question_bottom_sheet/custom_question_filed.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class CourseCodeField extends StatelessWidget {
  const CourseCodeField({super.key, required this.courseCode, required this.onChanged});
  final String courseCode;
  final void Function(String)? onChanged;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      trailing:  Icon(Icons.menu_book_outlined ,color : Theme.of(context).primaryColor.withOpacity(0.9),),
      title: CustomQuestionField(
        isCourseCode: true,
        hintText: 'Enter course code',

              onChanged: onChanged,
        value: courseCode ,
        labelText: 'Course code',
        validator: (input) => input?.trim().isEmpty ?? true ? 'Enter valid course code' : null,
        keyboardType: TextInputType.text,
      ),
    );
  }
}
