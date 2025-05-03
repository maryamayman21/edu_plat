import 'package:edu_platt/presentation/Doctor/features/online_exam/presentation/widgets/make_online_exam_widgets/question_bottom_sheet/custom_question_filed.dart';
import 'package:edu_platt/presentation/Doctor/features/online_exam/presentation/widgets/pdf_exam_widgets/custom_text_field.dart';
import 'package:flutter/material.dart';

class LevelField extends StatelessWidget {
  const LevelField({super.key, required this.level, this.onChanged});
  final String level;
  final void Function(String)? onChanged;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      trailing:  Icon(Icons.format_list_numbered_rtl_rounded ,color : Theme.of(context).primaryColor.withOpacity(0.9),),
      title: CustomTextField(
        isCourseCode: true,
        hintText: 'Enter level',
        onChanged: onChanged,
        value:level ,
        labelText: 'Level',
        validator: (input) => input?.trim().isEmpty ?? true ? 'Enter valid level' : null,
        keyboardType: TextInputType.number,
      ),
    );
  }
}
