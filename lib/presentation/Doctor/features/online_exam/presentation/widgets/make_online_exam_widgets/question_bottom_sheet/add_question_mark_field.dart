
import 'package:edu_platt/presentation/Doctor/features/online_exam/presentation/widgets/make_online_exam_widgets/question_bottom_sheet/custom_question_filed.dart';
import 'package:flutter/material.dart';

class QuestionDegreeField extends StatelessWidget {
  final String questionDegree;
  final Function(String) onChanged;

  const QuestionDegreeField({super.key, required this.questionDegree, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      trailing:  Icon(Icons.numbers ,color : Theme.of(context).primaryColor.withOpacity(0.9),),
      title: CustomQuestionField(

        keyboardType: TextInputType.number,
        hintText: 'Enter question mark',
        validator: (input) => input?.trim().isEmpty ?? true ? 'Enter valid mark' : null,
        labelText: 'Question degree',
        value: questionDegree,
        onChanged: onChanged, isCourseCode: false,
      ),
    );
  }
}