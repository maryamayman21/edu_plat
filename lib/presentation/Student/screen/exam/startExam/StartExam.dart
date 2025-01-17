import 'package:edu_platt/core/utils/Color/color.dart';
import 'package:edu_platt/presentation/Routes/custom_AppRoutes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Startexam extends StatelessWidget {
  const Startexam({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F6FA),
      appBar: AppBar(
        title: const Text('Exams', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: const [
          ExamCard(
            title: "Quiz",
            type: "online",
            date: "07/09/2024",
            duration: "15 mins",
            grading: "10 Mark",
            questions: "5 Questions",
            location: null,
          ),
          SizedBox(height: 16),
          ExamCard(
            title: "MidTerm Exam",
            type: "offline",
            date: "07/09/2024",
            duration: "30 mins",
            grading: "20 Mark",
            questions: "20 Questions",
            location: "Class 9",
          ),
        ],
      ),
    );
  }
}

class ExamCard extends StatelessWidget {
  final String title;
  final String type; // "online" or "offline"
  final String date;
  final String duration;
  final String grading;
  final String questions;
  final String? location; // Optional for online exams

  const ExamCard({
    required this.title,
    required this.type,
    required this.date,
    required this.duration,
    required this.grading,
    required this.questions,
    this.location,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 25.sp,
                      fontWeight: FontWeight.bold,
                      color: color.primaryColor,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: type == "online" ? Colors.green : Colors.grey,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      "[$type]".toUpperCase(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                "Date: $date",
                style: const TextStyle(color: Colors.grey, fontSize: 13),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Duration: $duration",
                    style: const TextStyle(color: Colors.black, fontSize: 16),
                  ),
                  Text(
                    questions,
                    style: const TextStyle(color: Colors.black, fontSize: 16),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                "Grading: $grading",
                style: const TextStyle(color: Colors.black, fontSize: 16),
              ),
              const SizedBox(height: 8),
              if (location != null)
                Text(
                  "Location: $location",
                  style: const TextStyle(color: Colors.black, fontSize: 14),
                ),
              const SizedBox(height: 16),
              Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                  onPressed: () {
                    if (type == "online") {
                      Navigator.pushNamed(context, AppRouters.ExamScreen);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text(
                                'This exam is offline and cannot be started.')),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        type == "online" ? color.primaryColor : Colors.grey,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    type == "online" ? "Start" : "View",
                    style: TextStyle(color: Colors.white, fontSize: 25.sp),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
