import 'package:edu_platt/core/DataModel/exam_dashboard_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class DashboardCard extends StatelessWidget {
  final DashboardItem item;



  const DashboardCard({required this.item,});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: item.backGroundColor,
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.r), // Responsive border radius
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12.r), // Responsive border radius
        onTap: (){

          if(item.title == 'View Recent Exams'){
            Navigator.pushNamed(context, item.routeName, arguments: true);
          }
          else if(item.title == 'Upcoming Exams'){
            Navigator.pushNamed(context, item.routeName, arguments:  false);
          }else if(item.title == 'Create PDF Exam (MCQ)'){
            Navigator.pushNamed(context, item.routeName, arguments:  false);
          }
          else if(item.title == 'Create PDF Exam (Written)'){
            Navigator.pushNamed(context, item.routeName, arguments: true);
          }
          else if(item.title == 'Recent Exams'){
            Navigator.pushNamed(context, item.routeName, arguments:true);
          }
          else{
            Navigator.pushNamed(context, item.routeName);
          }
        },
        child: Padding(
          padding: EdgeInsets.all(16.w), // Responsive padding
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                item.icon,
                size: 48.sp, // Responsive icon size
                color: item.color,
              ),
              SizedBox(height: 16.h), // Responsive spacing
              Text(
                item.title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.sp, // Responsive font size
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}