

import 'package:edu_platt/core/DataModel/exam_dashboard_model.dart';
import 'package:edu_platt/core/utils/Color/color.dart';
import 'package:edu_platt/presentation/Doctor/features/online_exam/presentation/widgets/exam_item_widgets/exam_dashboard_card.dart';
import 'package:edu_platt/presentation/Routes/custom_AppRoutes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class StudentExamTab extends StatelessWidget {
  // List of dashboard items
  StudentExamTab({super.key});
  final List<DashboardItem> items = [
    DashboardItem(
        title: 'Recent Exams',
        icon: Icons.refresh_outlined,
        color: Colors.white,
        backGroundColor: Colors.blue,
        routeName:  AppRouters.studentExamsScreen
    ),
    DashboardItem(
        title: 'Upcoming Exams',
        icon: Icons.upcoming_outlined,
        color: Colors.white,
        backGroundColor: Colors.green,
        routeName:  AppRouters.studentExamsScreen
    ),

  ];



  @override
  Widget build(BuildContext context) {
    return Scaffold(
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