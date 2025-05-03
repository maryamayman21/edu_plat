import 'package:edu_platt/presentation/Doctor/features/online_exam/presentation/widgets/make_online_exam_widgets/question_bottom_sheet/custom_question_filed.dart';
import 'package:flutter/material.dart';
class ExamLocationField extends StatelessWidget {
  const ExamLocationField({super.key, required this.examLocation, required this.onChanged});
  final String examLocation;
  final void Function(String)? onChanged;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      trailing:  Icon(Icons.location_on ,color : Theme.of(context).primaryColor.withOpacity(0.9),),
      title: CustomQuestionField(
        isCourseCode: false,
        hintText: 'Enter exam location',
        onChanged: onChanged,
        value: examLocation ,
        labelText: 'Exam Location',
        validator: (input) => input?.trim().isEmpty ?? true ? 'Enter valid exam location' : null,
        keyboardType: TextInputType.text,
      ),
    );
  }
}