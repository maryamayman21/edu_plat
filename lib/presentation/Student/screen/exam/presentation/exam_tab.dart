

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
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: LayoutBuilder(
            builder: (context, constraints) {
              return Wrap(
                spacing: 16.w,
                runSpacing: 16.h,
                alignment: WrapAlignment.center,
                runAlignment: WrapAlignment.center,
                children: items.map((item) {
                  return SizedBox(
                    width: (constraints.maxWidth < 600)
                        ? constraints.maxWidth * 0.8
                        : constraints.maxWidth * 0.4, // Responsive width
                    child: DashboardCard(item: item),
                  );
                }).toList(),
              );
            },
          ),
        ),
      ),
    );
  }

}