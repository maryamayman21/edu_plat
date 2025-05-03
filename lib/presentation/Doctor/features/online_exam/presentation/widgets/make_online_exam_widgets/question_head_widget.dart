import 'package:edu_platt/presentation/Doctor/features/online_exam/presentation/bloc/online_exam_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class QuestionHeadWidget extends StatelessWidget {
  const QuestionHeadWidget({super.key, required this.questionText, required this.questionIndex});
 final String questionText;
 final int questionIndex;
  @override
  Widget build(BuildContext context) {
    return  ListTile(
      title: Text(
          questionText
      ),
      trailing: IconButton(
          icon: const Icon(Icons.close, color: Colors.red),
          onPressed: () {
            context.read<OnlineExamBloc>().add(
                RemoveQuestionEvent(questionIndex));
           // _optionTexts.remove(qIndex);
            //print(_optionTexts);
          }

      ),
    );
  }
}
