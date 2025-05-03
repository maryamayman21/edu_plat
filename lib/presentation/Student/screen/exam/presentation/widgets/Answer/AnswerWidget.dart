
import 'package:edu_platt/core/utils/Color/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Answerwidget extends StatelessWidget {
  String text;
  final bool isSelected;
  final bool isCorrect;
  final VoidCallback onTap;

  Answerwidget(
      {required this.text,
      required this.isCorrect,
      required this.isSelected,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: REdgeInsets.only(left: 20, right: 20, top: 5, bottom: 5),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 60.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(30.r)),
            color: isSelected
                ? (isCorrect ? color.secondColor : Colors.red)
                : Colors.white,
          ),
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Text(
              text,
              style: TextStyle(
                fontSize: 23.sp,
                color: isSelected ? Colors.white : color.primaryColor,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
