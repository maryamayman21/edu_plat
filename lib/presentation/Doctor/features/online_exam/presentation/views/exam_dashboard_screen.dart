

import 'package:edu_platt/core/DataModel/exam_dashboard_model.dart';
import 'package:edu_platt/core/utils/Color/color.dart';
import 'package:edu_platt/presentation/Doctor/features/online_exam/presentation/widgets/exam_item_widgets/exam_dashboard_card.dart';
import 'package:edu_platt/presentation/Routes/custom_AppRoutes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class DashboardScreen extends StatelessWidget {
  // List of dashboard items
  DashboardScreen({super.key});
  final List<DashboardItem> items = [
    DashboardItem(
      title: 'Make Online Exam',
      icon: Icons.online_prediction_outlined,
      color: Colors.white,
      backGroundColor: Colors.blue,
     routeName:  AppRouters.doctorMakeAnOnlineExamRoute
    ),
    DashboardItem(
      title: 'Make Offline Exam Announcement',
      icon: Icons.offline_bolt_outlined,
      color: Colors.white,
      backGroundColor: Colors.green,
     routeName:  AppRouters.doctorOfflineExamScreen
    ),
    DashboardItem(
      title: 'Create PDF Exam (Written)',
      icon: Icons.article_outlined,
      color: Colors.white,
      backGroundColor: Colors.orange,
      routeName: AppRouters.doctorExamCourseSelectionScreen
    ),
    DashboardItem(
      title: 'Create PDF Exam (MCQ)',
      icon: Icons.quiz_outlined,
      color: Colors.white,
      backGroundColor: Colors.deepPurpleAccent,
      routeName: AppRouters.doctorExamCourseSelectionScreen
    ),
    DashboardItem(
      backGroundColor: Colors.pinkAccent,
      title: 'View Recent Exams',
      icon: Icons.history,
      color: Colors.white,
     routeName: AppRouters.doctorExamsViews
    ), DashboardItem(
      backGroundColor: Colors.purple,
      title: 'Upcoming Exams',
      icon: Icons.upcoming_outlined,
      color: Colors.white,
     routeName: AppRouters.doctorExamsViews
    ),
  ];



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title:  Text('Exam Dashboard',
          style: TextStyle(
            fontSize: 22.sp, // Slightly smaller for better balance
            fontWeight: FontWeight.bold,
            color: color.primaryColor,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.w), // Responsive padding
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: _getCrossAxisCount(context), // Responsive grid
            crossAxisSpacing: 16.w, // Responsive spacing
            mainAxisSpacing: 16.w, // Responsive spacing
            childAspectRatio: 1.0, // Square components
          ),
          itemCount: items.length,
          itemBuilder: (context, index) {
            return DashboardCard(item: items[index]);
          },
        ),
      ),
    );
  }

  // Responsive grid: 2 columns for mobile, 3 for tablet/desktop
  int _getCrossAxisCount(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth > 600) {
      return 3; // Tablet/desktop
    } else {
      return 2; // Mobile
    }
  }
}