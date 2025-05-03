import 'package:edu_platt/presentation/Doctor/features/course_details_utils/dialog_helper_function.dart';
import 'package:edu_platt/presentation/Doctor/features/online_exam/presentation/bloc/online_exam_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../sharedWidget/buttons/custom_button.dart';

class SaveQuestionButton extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController questionController;
  final List<String> optionTexts;
  final Duration duration;
  final String questionDegree;
  final OnlineExamBloc onlineExamBloc;
  final int? correctAnswerIndex;

  const SaveQuestionButton({
    super.key,
    required this.formKey,
    required this.questionController,
    required this.optionTexts,
    required this.duration,
    required this.questionDegree,
    required this.onlineExamBloc, this.correctAnswerIndex,
  });

  @override
  Widget build(BuildContext context) {
    return CustomButtonWidget(
      child: Text(
        'Save Question',
        style: TextStyle(
          fontSize: 18.sp, // Responsive font size
          fontWeight: FontWeight.w800,
          color: Colors.white,
        ),
      ),
      onPressed: () {
        if (!formKey.currentState!.validate()) return;
        if (optionTexts.length < 2) {
          showErrorDialog(context);
          return;
        }
        onlineExamBloc.add(
          AddQuestionWithOptionsEvent(
         correctAnswerIndex:  correctAnswerIndex ?? 0,
            questionText: questionController.text,
            options: optionTexts,
            duration: duration,
            questionDegree: int.parse(questionDegree),

          ),
        );
        Navigator.pop(context);
      },
    );
  }
}