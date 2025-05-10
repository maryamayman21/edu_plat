import 'package:edu_platt/presentation/Doctor/features/online_exam/presentation/widgets/make_online_exam_widgets/question_bottom_sheet/custom_question_filed.dart';
import 'package:edu_platt/presentation/Doctor/features/online_exam/presentation/widgets/pdf_exam_widgets/custom_text_field.dart';
import 'package:flutter/material.dart';

class TimeFiled extends StatelessWidget {
  const TimeFiled({super.key, required this.timeInHour, this.onChanged});
  final String timeInHour;
  final void Function(String)? onChanged;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      trailing:  Icon(Icons.timer ,color : Theme.of(context).primaryColor.withOpacity(0.9),),
      title: CustomTextField(
        isCourseCode: true,
        hintText: 'Enter time',
        onChanged: onChanged,
        value: timeInHour ,
        labelText: 'Time (in hours)',
        validator: (input) => input?.trim().isEmpty ?? true ? 'Enter valid time' : null,
        keyboardType: TextInputType.number,
      ),
    );
  }
}
