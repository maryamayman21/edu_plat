
import 'package:edu_platt/presentation/Student/screen/exam/domain/entity/exam_card_entity.dart';
import 'package:edu_platt/presentation/Student/screen/exam/presentation/bloc/exam_bloc.dart';
import 'package:edu_platt/presentation/Student/screen/exam/presentation/widgets/exam_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class ExamListview extends StatelessWidget {
  const ExamListview({super.key, required this.examCards});

  final List<StudentExamCardEntity> examCards;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: examCards.length,
      itemBuilder: (context, index) {
        final exams = examCards[index];
        return ExamCard(
            studentExam: exams,
            onPressed: () {
              context.read<ExamBloc>().add(
                  StartExamEvent(examCards[index].examId));
            }
        );
      },
    );
  }
}