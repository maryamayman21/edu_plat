import 'package:edu_platt/presentation/Doctor/features/online_exam/presentation/widgets/make_online_exam_widgets/question_bottom_sheet/custom_question_filed.dart';
import 'package:flutter/material.dart';
class CourseTitleField extends StatelessWidget {
  const CourseTitleField({super.key, required this.courseTitle, required this.onChanged});
  final String courseTitle;
  final void Function(String)? onChanged;
  @override
  Widget build(BuildContext context) {
    return ListTile(
     // trailing:  Icon(Icons.title ,color : Theme.of(context).primaryColor.withOpacity(0.9),),
      title: CustomQuestionField(
        isCourseCode: false,
        hintText: 'Enter exam title',
        onChanged: onChanged,
        value: courseTitle ,
        labelText: 'Exam Title',
        validator: (input) => input?.trim().isEmpty ?? true ? 'Enter valid exam title' : null,
        keyboardType: TextInputType.text,
      ),
    );
  }
}