import 'package:edu_platt/presentation/Doctor/features/online_exam/data/model/question_model.dart';
import 'package:edu_platt/presentation/Doctor/features/online_exam/presentation/widgets/pdf_exam_widgets/mcq_question_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class QuestionWidgetListView extends StatelessWidget {
  const QuestionWidgetListView({
    super.key,
    required this.questions, required this.isWrittenExam,

  });
  final bool isWrittenExam;
  final List<QuestionModel> questions;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: questions.length,
      itemBuilder: (context, qIndex) {
        final question = questions[qIndex];

        return Container(
          margin: EdgeInsets.all(ScreenUtil().setWidth(20.0)),// Add some margin
          decoration: BoxDecoration(
            border: !question.isValid
                ? Border.all(
              color: Colors.red, // Red border for invalid questions
              width: 1, // Border width
            )
                : null, // No border for valid questions
            borderRadius: BorderRadius.circular(15.r), // Rounded corners
            color: Colors.transparent, // Transparent background
          ),
          child: McqQuestionCard(
            question: question,
            qIndex: qIndex, isWrittenExam: isWrittenExam,
          ),
        );
      },
    );
  }
}
