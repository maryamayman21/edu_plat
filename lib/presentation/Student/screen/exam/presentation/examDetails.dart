import 'dart:async';
import 'package:edu_platt/core/utils/Color/color.dart';
import 'package:edu_platt/presentation/Student/screen/exam/presentation/widgets/Answer/AnswerWidget.dart';
import 'package:edu_platt/presentation/Student/screen/exam/presentation/widgets/question/QuestionWidget.dart';
import 'package:edu_platt/presentation/Student/screen/exam/presentation/widgets/question/result/Result.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Examdetails extends StatefulWidget {
  const Examdetails({super.key});

  @override
  State<Examdetails> createState() => _ExamdetailsState();
}

class _ExamdetailsState extends State<Examdetails>
    with SingleTickerProviderStateMixin {
  int currentQuestionIndex = 0;
  String? selectedAnswer;
  int correctAnswers = 0;
  Timer? _timer;
  int timeRemaining = 15;
  int totalScore = 0;
  int earnedScore = 0;

  final List<Map<String, dynamic>> questions = [
    {
      "question": "Which is not a feature of OOP in general definitions?",
      "answers": [
        "Efficient Code",
        "Code reusability",
        "Modularity",
        "Duplicate/Redundant data"
      ],
      "correctAnswer": "Duplicate/Redundant data",
      "score": 2,
    },
    {
      "question":
          "Which was the first purely object oriented programming language developed?",
      "answers": [" SmallTalk", "HTML", "Java", "C++"],
      "correctAnswer": " SmallTalk",
      "score": 3,
    },
    {
      "question": "When OOP concept did first came into picture?",
      "answers": ["1980’s", "1995", "1970’s", "1993"],
      "correctAnswer": "1970’s",
      "score": 1,
    },
    {
      "question": "Which feature of OOP indicates code reusability?",
      "answers": [
        " Abstraction",
        "Polymorphism",
        "Encapsulation",
        "Inheritance"
      ],
      "correctAnswer": "Inheritance",
      "score": 2,
    },
    {
      "question": "Which header file is required in C++ to use OOP?",
      "answers": [
        "without using any header file",
        " stdlib.h",
        " iostream.h",
        "stdio.h"
      ],
      "correctAnswer": "without using any header file",
      "score": 2,
    },
  ];

  void _startTimer() {
    _timer?.cancel(); // أوقف أي مؤقت سابق
    setState(() {
      timeRemaining = 15; // إعادة تعيين الوقت لكل سؤال
    });
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (timeRemaining > 0) {
        setState(() {
          timeRemaining--;
        });
      } else {
        _timer?.cancel();
        nextQuestion(); // الانتقال للسؤال التالي تلقائيًا عند انتهاء الوقت
      }
    });
  }

  void nextQuestion() {
    if (currentQuestionIndex < questions.length - 1) {
      setState(() {
        currentQuestionIndex++;
        selectedAnswer = null;
      });
      _startTimer(); // إعادة بدء المؤقت للسؤال الجديد
    } else {
      _timer?.cancel(); // إيقاف المؤقت عند انتهاء الاختبار
      _showResultDialog();
    }
  }

  void selectAnswer(String answer) {
    if (selectedAnswer == null) {
      setState(() {
        selectedAnswer = answer;
        if (answer == questions[currentQuestionIndex]["correctAnswer"]) {
          correctAnswers++;
          earnedScore += questions[currentQuestionIndex]["score"] as int;
        }
      });
      _timer?.cancel(); // أوقف المؤقت إذا اختار المستخدم الإجابة
    }
  }

  void _showResultDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ResultDialog(
          correctAnswers: correctAnswers,
          totalScore: totalScore,
          earnedScore: earnedScore,
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    for (var question in questions) {
      totalScore += question['score'] as int;
    }
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentQuestion = questions[currentQuestionIndex];
    final correctAnswer = currentQuestion["correctAnswer"] as String;
    return Scaffold(
      backgroundColor: color.primaryColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: 50.h),
          Text(
            "Time: $timeRemaining seconds",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18.sp, color: Colors.red),
          ),
          SizedBox(
            height: 175.h,
          ),
         Questionwidget(text: currentQuestion["question"] as String),
          Expanded(
            child: ListView.builder(
              itemCount: (currentQuestion["answers"] as List<String>).length,
              itemBuilder: (context, index) {
                final answer = currentQuestion["answers"][index];
                final isCorrect = answer == correctAnswer;
                final isSelected = answer == selectedAnswer;

                return Answerwidget(
                  text: answer,
                  isSelected: isSelected,
                  isCorrect: isCorrect,
                  onTap: () => selectAnswer(answer),
                );
              },
            ),
          ),
          Padding(
            padding: REdgeInsets.only(left: 120, right: 120),
            child: ElevatedButton(
              onPressed: selectedAnswer != null ? nextQuestion : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF31ED34),
                padding: REdgeInsets.symmetric(vertical: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15).r,
                ),
              ),
              child: Text(
                "Next",
                style: Theme.of(context)
                    .textTheme
                    .titleSmall
                    ?.copyWith(color: Colors.white, fontSize: 22.sp),
              ),
            ),
          ),
          SizedBox(
            height: 100.h,
          )
        ],
      ),
    );
  }
}
