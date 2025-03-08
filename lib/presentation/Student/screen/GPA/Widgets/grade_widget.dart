import 'package:edu_platt/core/utils/Color/color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GradeWidget extends StatefulWidget {
  final String selectedGrade;
  final ValueChanged<String> onChanged;

   GradeWidget({required this.selectedGrade, required this.onChanged});

  @override
  State<GradeWidget> createState() => _GradeWidgetState();
}

class _GradeWidgetState extends State<GradeWidget> {
  final List<String> grades = [ "A", "A-", "B+", "B", "C+", "C", "D", "F"];
  @override
  Widget build(BuildContext context) {
    return Container(
        child: DropdownButton<String>(
          value: widget.selectedGrade,
          items: grades.map((String grade) {
            return DropdownMenuItem<String>(
              value: grade,
              child: Text(
                grade,
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  color: color.secondColor,
                ),
              ),
            );
          }).toList(),
          onChanged: (String? newValue) {
            if (newValue != null) {
              widget.onChanged(newValue);
            }
          },
          icon: Padding(
            padding: REdgeInsets.only(left: 20.0),
            child: Icon(Icons.arrow_drop_down, color: color.secondColor, size: 30.sp),
          ),
        ),

    );
  }
}
