import 'dart:async';
import 'package:edu_platt/core/cashe/services/questions_cashe_service.dart';
import 'package:edu_platt/core/utils/Color/color.dart';
import 'package:edu_platt/presentation/Doctor/features/online_exam/data/model/exam_model.dart';
import 'package:edu_platt/presentation/Doctor/features/online_exam/data/model/option_model.dart';
import 'package:edu_platt/presentation/Doctor/features/online_exam/data/model/question_model.dart';
import 'package:edu_platt/presentation/Routes/custom_AppRoutes.dart';
import 'package:edu_platt/presentation/Student/screen/exam/data/model/student_exam_model.dart';
import 'package:edu_platt/presentation/Student/screen/exam/data/model/submit_exam_model.dart';
import 'package:edu_platt/presentation/Student/screen/exam/data/model/submit_question_model.dart';
import 'package:edu_platt/presentation/Student/screen/exam/presentation/widgets/question/result/Result.dart';
import 'package:edu_platt/presentation/Student/screen/exam/presentation/widgets/question_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:no_screenshot/no_screenshot.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key, required this.exam});
  final StudentExamModel exam ;

  @override
  State<QuizScreen> createState() => _ExamdetailsState();
}

class _ExamdetailsState extends State<QuizScreen>
    with SingleTickerProviderStateMixin {
  int currentQuestionIndex = 0;
  int? selectedOptionIndex;
  //int correctAnswers = 0;
  Timer? _timer;
  int timeRemaining = 0;
  //int totalScore = 0;
 // int earnedScore = 0;
  final NoScreenshot _noScreenshot = NoScreenshot();
  void _startTimer(int questionDurationInMinutes) {
    _timer?.cancel(); // Stop any previous timer

    setState(() {
      timeRemaining = questionDurationInMinutes * 60; // total seconds
    });

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (timeRemaining > 0) {
        setState(() {
          timeRemaining--;
        });
      } else {
        _timer?.cancel();
        _moveToNextQuestion(); // Automatically move to next question
      }
    });
  }
  String formatTime(int seconds) {
    final minutes = (seconds ~/ 60).toString().padLeft(2, '0');
    final remainingSeconds = (seconds % 60).toString().padLeft(2, '0');
    return '$minutes:$remainingSeconds';
  }


  void _moveToNextQuestion()async {

    if (selectedOptionIndex != null) {
      print('Selected option index $selectedOptionIndex');

      ///TODO :: SET CACHE SERVICE
     await  QuestionsCacheService().saveQuestion(SubmitQuestionModel(answerId: widget.exam.questions[currentQuestionIndex].id, selectedChoiceId: widget.exam.questions[currentQuestionIndex].choices[selectedOptionIndex!].id));
         print('answer ID : ${widget.exam.questions[currentQuestionIndex].id} cashed ');
      print('choice  ID : ${widget.exam.questions[currentQuestionIndex].choices[selectedOptionIndex!].id} cashed ');

      // Check if the selected answer is correct
      // if (questions[currentQuestionIndex]
      //     .options[selectedOptionIndex!]
      //     .isCorrectAnswer) {
      //   correctAnswers++;
      //   earnedScore += questions[currentQuestionIndex].degree ?? 0;
      // }
    }

    // Move to the next question
    ///TODO:: MINUS ONE
    if (currentQuestionIndex < widget.exam.questions.length - 1) {
      setState(() {
        currentQuestionIndex++;
        selectedOptionIndex = null;
      });
      _startTimer(widget.exam.questions[currentQuestionIndex].timeInMin);
    } else {
      _timer?.cancel(); // Stop the timer when the quiz ends
      _navigateToQuizResultView();
    }
  }

  void selectAnswer(int index) {
    setState(() {
      selectedOptionIndex = index; // Update the selected answer
    });
  }


  void _navigateToQuizResultView()async {
    ///TODO:: NEED TO REFACTOR THIS -> NO NEED TO PASS THESE ARGUMENTS
    ///TODO:: NEED TO GET THE CACHED ANSWERS AND PASS IT
    final List<SubmitQuestionModel> cachedAnswers =  await QuestionsCacheService().getAllQuestions();
     final SubmitExamModel exam = SubmitExamModel(examId: widget.exam.id, questionModel:cachedAnswers);
    Navigator.pushNamedAndRemoveUntil(
      context,
      AppRouters.studentQuizResultScreen, // Navigate to the result screen
          (Route<dynamic> route) => false, // Remove all routes until the first route (home screen)
      arguments: exam
    );

  }



  @override
  void initState() {
    super.initState();
    _noScreenshot.screenshotOff();
    _startTimer(widget.exam.questions[currentQuestionIndex].timeInMin);
  }


  @override
  void dispose() {
    _noScreenshot.screenshotOn();
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentQuestion = widget.exam.questions[currentQuestionIndex];
    return Scaffold(
      backgroundColor: color.primaryColor, // Replace with your color
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(height: 100.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              QuestionTimer(
                iconData: Icons.grade,
                questionData:currentQuestion.marks.toString(),
                questionText: 'marks',
              ),
              QuestionTimer(
                  questionData:formatTime(timeRemaining),
                questionText: 'min',
                iconData: Icons.timer,

              ),
            ],
          ),
          SizedBox(height: 60.h),
          Text(
            currentQuestion.questionText,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.white,
                fontSize: 20.sp, fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: currentQuestion.choices.length,
              itemBuilder: (context, index) {
                final option = currentQuestion.choices[index];
                final isSelected = index == selectedOptionIndex;
                return GestureDetector(
                  onTap: () =>
                      selectAnswer(index), // Allow selecting any answer
                  child: Container(
                    margin:
                        EdgeInsets.symmetric(vertical: 5.h, horizontal: 16.w),
                    padding: EdgeInsets.all(16.w),
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.green[300] : Colors.grey[200],
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Text(
                      option.text,
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: isSelected ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 120.w),
            child: ElevatedButton(
              onPressed:selectedOptionIndex  != null ? _moveToNextQuestion:null, // Always enabled
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green, // Replace with your color
                padding: EdgeInsets.symmetric(vertical: 10.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.r),
                ),
              ),
              child: Text(
                "Next",
                style: TextStyle(fontSize: 22.sp, color: Colors.white),
              ),
            ),
          ),
       SizedBox(height: 100.h,)
        ],
      ),
    );
  }
}
