import 'package:edu_platt/presentation/Doctor/features/online_exam/presentation/widgets/make_online_exam_widgets/counter_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CounterListview extends StatelessWidget {
  const CounterListview({super.key, required this.totalDegree, required this.noOfQuestion, required this.duration});
  final int totalDegree;
  final int noOfQuestion;
  final Duration duration;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //SizedBox(height: 30.h,),
        Expanded(

          child: ListView(
            scrollDirection: Axis.horizontal,

            children: [

              AnimatedCounter (
                value: noOfQuestion,
                label: "Questions",
                color: Colors.amber, // Custom background color
              ),
              AnimatedCounter (
                value: totalDegree,
                label: "Total Marks",
                color: Colors.green, // Custom background color
              ),
              AnimatedCounter (
                isDuration: true,
                value: duration.inMinutes.toInt(),
                label: "Total Duration ",
                color: Colors.orange, // Custom background color
              ),

            ],
          ),
        ),
      ],
    );
  }
}
