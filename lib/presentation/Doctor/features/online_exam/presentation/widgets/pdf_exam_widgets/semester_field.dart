import 'package:edu_platt/presentation/Doctor/features/online_exam/presentation/widgets/make_online_exam_widgets/question_bottom_sheet/custom_question_filed.dart';
import 'package:edu_platt/presentation/Doctor/features/online_exam/presentation/widgets/pdf_exam_widgets/custom_text_field.dart';
import 'package:flutter/material.dart';

class SemesterField extends StatelessWidget {
  const SemesterField({super.key, required this.semester, this.onChanged});
  final String semester;
  final void Function(String)? onChanged;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      trailing:  Icon(Icons.book_outlined ,color : Theme.of(context).primaryColor.withOpacity(0.9),),
      title: CustomTextField(
        isCourseCode: true,
        hintText: 'Enter Semester',
        onChanged: onChanged,
        value:semester ,
        labelText: 'Semester',
        validator: (input) => input?.trim().isEmpty ?? true ? 'Enter valid semester' : null ,
        keyboardType: TextInputType.number,
      ),
    );
  }
}
