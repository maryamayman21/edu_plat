import 'package:edu_platt/presentation/Doctor/features/online_exam/presentation/widgets/make_online_exam_widgets/question_bottom_sheet/custom_question_filed.dart';
import 'package:edu_platt/presentation/Doctor/features/online_exam/presentation/widgets/pdf_exam_widgets/custom_text_field.dart';
import 'package:flutter/material.dart';

class ProgramField extends StatelessWidget {
  const ProgramField({super.key, required this.program, this.onChanged});
  final String program;
  final void Function(String)? onChanged;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      trailing:  Icon(Icons.category_outlined ,color : Theme.of(context).primaryColor.withOpacity(0.9),),
      title: CustomTextField(
        isCourseCode: true,
        hintText: 'Enter Program',
        onChanged: onChanged,
        value:program ,
        labelText: 'Program',
        validator: (input) => input?.trim().isEmpty ?? true ? 'Enter valid Program' : null,
        keyboardType: TextInputType.text,
      ),
    );
  }
}
