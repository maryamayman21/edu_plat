import 'package:edu_platt/presentation/Doctor/features/course_details_utils/dialog_helper_function.dart';
import 'package:edu_platt/presentation/Doctor/features/online_exam/presentation/bloc/pdf_exam_bloc.dart';
import 'package:edu_platt/presentation/sharedWidget/buttons/custom_button.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class McqSaveQuestionButton extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController questionController;
  final List<String> optionTexts;
  final String? questionDegree;
  final PDFExamBloc pdfExamBloc;


  const McqSaveQuestionButton({
    super.key,
    required this.formKey,
    required this.questionController,
    required this.optionTexts,
    required this.questionDegree,
    required this.pdfExamBloc,
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
        pdfExamBloc.add(
          AddQuestionWithOptionsEvent(
            parseQuestionDegree(questionDegree),
            questionText: questionController.text,
            options: optionTexts,
          ),
        );
        print('Question added');
        Navigator.pop(context);
      },
    );
  }
  int parseQuestionDegree(String? questionDegree) {
    try {
      // Handle null case first
      if (questionDegree == null) return 0;

      // Trim whitespace and check for empty string
      final trimmed = questionDegree.trim();
      if (trimmed.isEmpty) return 0;

      // Parse the string
      return int.parse(trimmed);
    } catch (e) {
      // Fallback for any parsing errors
      print('Error parsing question degree: $e');
      return 0;
    }
  }
}