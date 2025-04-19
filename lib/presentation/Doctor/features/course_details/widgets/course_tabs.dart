import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CourseTabsWidget extends StatelessWidget {
  final Function(Map<String, dynamic>) onTabChanged;
  final int currentIndex;
  final bool hasLab;

  const CourseTabsWidget({
    Key? key,
    required this.onTabChanged,
    required this.currentIndex, required this.hasLab,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final titles = hasLab ? ['Lectures', 'Labs', 'Exams', 'Videos'] :  ['Lectures','Exams', 'Videos'] ;

    return SizedBox(
      height: 50.h, // Set a fixed height for the tab container
      child: Align(
        alignment: Alignment.center,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(titles.length, (index) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.w),
                child: GestureDetector(
                  onTap: () => onTabChanged({'materialType' : titles[index] , 'currentIndex': index}),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      vertical: 10.h,
                      horizontal: 15.w,
                    ),
                    decoration: BoxDecoration(
                      color: index == currentIndex ? Theme.of(context).primaryColor : Colors.white,
                      borderRadius: BorderRadius.circular(30.r),
                      border: Border.all(color: Theme.of(context).primaryColor),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      titles[index],
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: index == currentIndex ? Colors.white :Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
