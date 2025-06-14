import 'package:edu_platt/core/utils/Color/color.dart';
import 'package:edu_platt/presentation/Student/screen/GPA/Widgets/Sgpa_Widget.dart';
import 'package:edu_platt/presentation/Student/screen/GPA/Widgets/course_widget.dart';
import 'package:edu_platt/presentation/Student/screen/GPA/Widgets/title_widget.dart';
import 'package:edu_platt/presentation/Student/screen/GPA/cubit/gpa_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Semestergpacalculator extends StatefulWidget {
  final Function(double) onSaveSGPA;
  const Semestergpacalculator({required this.onSaveSGPA});

  @override
  State<Semestergpacalculator> createState() => _SemestergpacalculatorState();
}

class _SemestergpacalculatorState extends State<Semestergpacalculator> {
  List<Map<String, dynamic>> semesters = [];
  double? calculatedSGPA;


  void addSemester() {
    setState(() {
      semesters.add({
        "credit": TextEditingController(),
        "sgpa": TextEditingController(),
      });
    });
  }

  void removeSemester(int index) {
    setState(() {
      semesters[index]["credit"]!.dispose();
      semesters[index]["sgpa"]!.dispose();
      semesters.removeAt(index);
    });
  }

  void calculateSGPA(BuildContext ctx) {
    double totalCredits = 0;
    double totalPoints = 0;

    for (var semester in semesters) {
      double? credit = double.tryParse(semester["credit"]!.text.trim());
      double? sgpa = double.tryParse(semester["sgpa"]!.text.trim());

      if (credit == null || credit < 1 || sgpa == null || sgpa > 4.0) {
        showDialog(
          context: ctx,
          builder: (context) => AlertDialog(
            title: Text("Input Error", style: TextStyle(fontSize: 28.sp, fontWeight: FontWeight.bold, color: Colors.red)),
            content: Text("Please enter valid values for Credit and SGPA (Max SGPA: 4.0)", style: TextStyle(fontSize: 25.sp,fontWeight: FontWeight.bold)),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey[200],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
                  child: Text(
                    "ok",
                    style: TextStyle(fontSize: 20.sp, color: color.primaryColor,fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        );
        return;
      }
      totalCredits += credit;
      totalPoints += (credit * sgpa);
    }
    if (totalCredits > 134) {
      showDialog(
        context: ctx,
        builder: (context) => AlertDialog(
          title: Text("Credit Limit Exceeded", style: TextStyle(fontSize: 28.sp, fontWeight: FontWeight.bold, color: Colors.red)),
          content: Text("Total credits must not exceed 134.", style: TextStyle(fontSize: 25.sp, fontWeight: FontWeight.bold)),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey[200],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.r),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
                child: Text(
                  "ok",
                  style: TextStyle(fontSize: 20.sp, color: color.primaryColor,fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      );
      return;
    }

    double newSGPA = (totalCredits == 0) ? 0.0 : (totalPoints / totalCredits);
    if (newSGPA != calculatedSGPA) {
      setState(() {
        calculatedSGPA = newSGPA;
      });
    }

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text("Calculated SGPA", style: TextStyle(fontSize: 25.sp, fontWeight: FontWeight.bold, color: color.primaryColor)),
        content: Text("Your SGPA is ${calculatedSGPA!.toStringAsFixed(2)}", style: TextStyle(fontSize: 28.sp, color: color.secondColor,fontWeight: FontWeight.bold)),
        actions: [
          Row(
            children: [
              ElevatedButton(
                onPressed:
                    () {
                //  widget.onSaveSGPA(calculatedSGPA ?? 0.0);
                  context.read<GpaCubit>().updateGpa(calculatedSGPA ?? 0.0).then((_) {
                    context.read<GpaCubit>().fetchGpa();
                  });
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey[200],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
                  child: Text(
                    "save",
                    style: TextStyle(fontSize: 20.sp, color: color.primaryColor,fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SizedBox(width: 10.w,),

              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey[200],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
                  child: Text(
                    "ok",
                    style: TextStyle(fontSize: 20.sp, color: color.primaryColor,fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),

        ],
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (context, constraints) {
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
                          TitleWidget(text: "SGPA"),
                          TitleWidget(text: "Remove"),
                        ],
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.all(10.h),
                        itemCount: semesters.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.symmetric(vertical: 5.h),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(width: 5.w,),
                                    SizedBox(
                                      width: 100.w,
                                      child: SgpaWidget(
                                          controller: semesters[index]["credit"],
                                          textColor: Colors.pinkAccent),
                                    ),
                                    SizedBox(
                                      width: 100.w,
                                      child: SgpaWidget(
                                          controller: semesters[index]["sgpa"],
                                          textColor: color.primaryColor),
                                    ),
                                    SizedBox(width: 20.w,),
                                    IconButton(
                                      icon: const Icon(
                                          Icons.delete, color: Colors.red),
                                      onPressed: () => removeSemester(index),
                                    ),
                                    SizedBox(width: 40.w),
                                  ],
                                ),
                                Divider(thickness: 2.r, color: Colors.white),
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CourseWidget(icon: Icons.add,
                  text: "Add Semester",
                  onTap: addSemester,),
                Padding(
                  padding: REdgeInsets.all(20.0),
                  child: InkWell(
                    onTap: () {
                      calculateSGPA(context);
                    },
                    child: TitleWidget(
                        text: "                    Calculate                    "),
                  ),
                ),
              ],


            ),

          ),


            ],
          );
        }
    );
  }
}
