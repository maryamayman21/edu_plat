import 'package:edu_platt/presentation/Student/screen/GPA/Widgets/Credit_widget.dart';
import 'package:edu_platt/presentation/Student/screen/GPA/Widgets/Dialog_Widget.dart';
import 'package:edu_platt/presentation/Student/screen/GPA/Widgets/course_widget.dart';
import 'package:edu_platt/presentation/Student/screen/GPA/Widgets/grade_widget.dart';
import 'package:edu_platt/presentation/Student/screen/GPA/Widgets/title_widget.dart';
import 'package:edu_platt/presentation/Student/screen/GPA/cubit/gpa_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Coursesgpacalculator extends StatefulWidget {


  @override
  State<Coursesgpacalculator> createState() => _CoursesgpacalculatorState();
}

class _CoursesgpacalculatorState extends State<Coursesgpacalculator> {
  List<Map<String, dynamic>> courses = [];
  double? calculatedCGPA;
  @override
  void initState() {
    super.initState();
  }

  void addCourse() {
    setState(() {
      courses.add({"credit": "1", "grade": "A"});
    });
  }

  void removeCourse(int index) {
    setState(() {
      courses.removeAt(index);
    });
  }

  void calculateCGPA() {
    double totalCredits = 0;
    double totalPoints = 0;
    Map<String, double> gradePoints = {
      "A": 4.00, "A-": 3.67,
      "B+": 3.33, "B": 3.00,
      "C+": 2.67, "C": 2.33,
      "D": 2.00, "F": 0.000,
    };

    for (var course in courses) {
      double credit = double.tryParse(course["credit"]) ?? 0;
      double point = gradePoints[course["grade"]] ?? 0;
      totalCredits += credit;
      totalPoints += (credit * point);
    }
    double newCGPA = (totalCredits == 0) ? 0.0 : (totalPoints / totalCredits);
    if (newCGPA != calculatedCGPA) {
      setState(() {
        calculatedCGPA = newCGPA;
      });
    }

    showDialog(
      context: context,
      builder: (context) => DialogWidget(
        totalCourses: courses.length.toString(),
        totalCredits: totalCredits.toStringAsFixed(2),
        totalPoints: totalPoints.toStringAsFixed(2),
        cgpa: calculatedCGPA!.toStringAsFixed(2),

      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder( builder: (context, constraints) {
      return Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.only(bottom: MediaQuery
                  .of(context)
                  .viewInsets
                  .bottom + 20.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
            
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TitleWidget(text: "Credit"),
                      TitleWidget(text: "Course Grade"),
                      TitleWidget(text: "Remove"),
                    ],
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.all(10.h),
                    itemCount: courses.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: REdgeInsets.symmetric(vertical: 5.h),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(width: 10.w),
                                SizedBox(
                                  width: 100.w,
                                  child: CreditWidget(
                                    selectedHour: courses[index]["credit"],
                                    onChanged: (value) {
                                      setState(() {
                                        courses[index]["credit"] = value;
                                      });
                                    },
                                  ),
                                ),
                                SizedBox(width: 20.w),
                                SizedBox(
                                  width: 90.w,
                                  child: GradeWidget(
                                    selectedGrade: courses[index]["grade"],
                                    onChanged: (value) {
                                      setState(() {
                                        courses[index]["grade"] = value;
                                      });
                                    },
                                  ),
                                ),
                                SizedBox(width: 30.w),
                                IconButton(
                                  icon: Icon(Icons.delete, color: Colors.red),
                                  onPressed: () => removeCourse(index),
                                ),
                                SizedBox(width: 10.w),
                              ],
                            ),
                            Divider(thickness: 2.r, color: Colors.white,)
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 10.h),
            color: Colors.transparent,
            child:Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                    CourseWidget(icon: Icons.add, text: "Add Course",onTap: addCourse,),
              Padding(
                  padding: REdgeInsets.all(20.0),
                  child: InkWell(
                    onTap:calculateCGPA ,
                    child: TitleWidget(
                        text: "                    Calculate                    "),
                  ),
                ),

              ],
            )

          )
        ],
      );
    }
    );
  }
}
