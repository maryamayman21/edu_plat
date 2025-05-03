
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
              onPressed: (){
                context.read<ExamBloc>().add(StartExamEvent(examCards[index].examId));
              }///TODO:: CALL StartExamEvent here -> Done
            );
      },
    );
  }
  bool isCurrentTimeInRange(DateTime startTime, int durationInMinutes) {
    // Parse the start time string into a DateTime object

    // Calculate the end time by adding the duration in minutes to the start time
    DateTime endTime = startTime.add(Duration(minutes: durationInMinutes));
    endTime =   DateTime(endTime.year, endTime.month, endTime.day, endTime.hour, endTime.minute, endTime.second);
     startTime = DateTime( startTime.year,  startTime.month,  startTime.day,  startTime.hour,  startTime.minute,  startTime.second);

     print('start time  : $startTime');
      print('end time  : $endTime');
    // Get the current date and time
    DateTime currentTime = DateTime.now();
    currentTime = DateTime(currentTime.year, currentTime.month, currentTime.day, currentTime.hour, currentTime.minute, currentTime.second);
    // Check if the current time is within the range [startTime, endTime]
    print('current time : $currentTime');
    print(currentTime.isAfter(startTime) && currentTime.isBefore(endTime));
    return currentTime.isAfter(startTime) && currentTime.isBefore(endTime);
  }
}