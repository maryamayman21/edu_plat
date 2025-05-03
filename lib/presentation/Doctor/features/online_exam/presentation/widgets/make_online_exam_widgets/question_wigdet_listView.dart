import 'package:edu_platt/presentation/Doctor/features/online_exam/data/model/question_model.dart';
import 'package:edu_platt/presentation/Doctor/features/online_exam/presentation/bloc/online_exam_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'question_card.dart';

class QuestionWidgetListView2 extends StatelessWidget {
  const QuestionWidgetListView2({
    super.key,
    required this.questions,

  });

  final List<QuestionModel> questions;

  @override
  Widget build(BuildContext context) {
    return SliverList.builder(
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
          child: QuestionCard(
            question: question,
            qIndex: qIndex,
          ),
        );
      },
    );
  }
}
