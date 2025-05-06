import 'package:edu_platt/presentation/Doctor/features/online_exam/presentation/widgets/make_online_exam_widgets/question_bottom_sheet/custom_question_filed.dart';
import 'package:edu_platt/presentation/Doctor/features/online_exam/presentation/widgets/pdf_exam_widgets/custom_text_field.dart';
import 'package:flutter/material.dart';

class CourseCodeField extends StatelessWidget {
  const CourseCodeField({super.key, required this.courseCode, this.onChanged});
  final String courseCode;
  final void Function(String)? onChanged;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      trailing:  Icon(Icons.title ,color : Theme.of(context).primaryColor.withOpacity(0.9),),
      title: CustomTextField(
        isCourseCode: true,
        hintText: 'Enter Course Code',
        onChanged: onChanged,
        value:courseCode ,
        labelText: 'Course Code',
        validator: (input) => input?.trim().isEmpty ?? true ? 'Enter valid course code' : null,
        keyboardType: TextInputType.text,
      ),
    );
  }
}
