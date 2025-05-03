import 'package:edu_platt/presentation/Doctor/features/online_exam/presentation/widgets/pdf_exam_widgets/custom_text_field.dart';
import 'package:flutter/material.dart';

class TotalMarkField extends StatelessWidget {
  const TotalMarkField({super.key, required this.totalMark, this.onChanged});
  final String totalMark;
  final void Function(String)? onChanged;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      trailing:  Icon(Icons.grade ,color : Theme.of(context).primaryColor.withOpacity(0.9),),
      title: CustomTextField(
        isCourseCode: true,
        hintText: 'Enter Total Mark',
        onChanged: onChanged,
        value:totalMark ,
        labelText: 'Total Mark',
        validator: (input) => input?.trim().isEmpty ?? true ? 'Enter valid input' : null,
        keyboardType: TextInputType.number,
      ),
    );
  }
}
