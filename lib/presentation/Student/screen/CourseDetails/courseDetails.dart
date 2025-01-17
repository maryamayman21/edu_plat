import 'package:edu_platt/core/DataModel/courseModel.dart';
import 'package:edu_platt/core/utils/Color/color.dart';
import 'package:edu_platt/presentation/Student/screen/CourseDetails/Widget_Course_header.dart';
import 'package:edu_platt/presentation/Student/screen/CourseDetails/Widget_course_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Coursedetails extends StatefulWidget {
  @override
  State<Coursedetails> createState() => _CoursedetailsState();
}

class _CoursedetailsState extends State<Coursedetails> {
  final List<CourseModel> courses = [
    CourseModel(
        courseCode: 'COMP 201',
        courseDescription: 'Design and Analysis Algorithms',
        creditHours: '3 credit hours',
        onTap: () {}),
    CourseModel(
        courseCode: 'COMP 203',
        courseDescription: 'Data Structure and Algorithms',
        creditHours: '3 credit hours',
        onTap: () {}),
    CourseModel(
        courseCode: 'COMP 205',
        courseDescription: 'Object-oriented programming',
        creditHours: '3 credit hours',
        onTap: () {}),
    CourseModel(
        courseCode: 'COMP 207',
        courseDescription: 'Database System',
        creditHours: '3 credit hours',
        onTap: () {}),
    CourseModel(
        courseCode: 'COMP 202',
        courseDescription: 'Data Structures',
        creditHours: '3 credit hours',
        onTap: () {}),
    CourseModel(
        courseCode: 'COMP 204',
        courseDescription: 'Computer Network',
        creditHours: '3 credit hours',
        onTap: () {}),
    CourseModel(
        courseCode: 'COMP 206',
        courseDescription: 'Web Programming',
        creditHours: '3 credit hours',
        onTap: () {}),
    CourseModel(
        courseCode: 'COMP 208',
        courseDescription: 'Automata',
        creditHours: '3 credit hours',
        onTap: () {}),
    CourseModel(
        courseCode: 'COMP 210',
        courseDescription: 'Graph',
        creditHours: '3 credit hours',
        onTap: () {}),
  ];

  int selectedIndex = 0; // Track the selected tab
  final List<String> courseCategories = ['Material', 'Labs', 'Exams'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(slivers: [
      // Header
      WidgetCourseHeader(courseCode: courses[selectedIndex].courseCode),
      SliverToBoxAdapter(child: SizedBox(height: 15.h)),
      SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            courses[selectedIndex].courseDescription,
            style: TextStyle(
              color: color.primaryColor,
              fontSize: 22.sp,
            ),
          ),
        ),
      ),
      SliverToBoxAdapter(
        child: Padding(
          padding: REdgeInsets.symmetric(horizontal: 16.0),
          child: CourseDetailsCard(
            courseTitle: courses[selectedIndex].courseCode,
            creditHours: courses[selectedIndex].creditHours,
            lectures: "12",
            // يمكنك تعديله حسب البيانات
            grading: "Grading",
            marks: [
              {
                'Midterm': '25',
                'Oral': '5',
                'Final Exam': '70',
                'Total Marks': '100',
              },
            ],
          ),
        ),
      ),
      SliverToBoxAdapter(child: SizedBox(height: 20.h)),
      SliverPersistentHeader(
        pinned: true,
        delegate: TabBarDelegate(
          child: WidgetCourseTabs(
            courseCategories: courseCategories,
            selectedIndex: selectedIndex,
            onTabSelected: (index) {
              setState(() {
                selectedIndex = index;
              });
            },
          ),
        ),
      ),

      // Tabs
    ]));
  }
}

class TabBarDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;

  TabBarDelegate({required this.child});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Material(
      child: Container(
        color: Colors.white, // Background color for the pinned area
        child: child,
      ),
    );
  }

  @override
  double get maxExtent => 52.0; // Height of the tab bar
  @override
  double get minExtent => 52.0; // Height of the tab bar

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true; // No need to rebuild
  }
}

class CourseDetailsCard extends StatelessWidget {
  final String courseTitle;
  final String creditHours;
  final String lectures;
  final String grading;
  final List<Map<String, String>> marks;

  CourseDetailsCard({
    required this.courseTitle,
    required this.creditHours,
    required this.lectures,
    required this.grading,
    required this.marks,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: REdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DetailIconText(
                  icon: Icons.lock_clock,
                  text: '3 credit hours',
                ),
                DetailIconText(
                  icon: Icons.library_books,
                  text: '$lectures Lectures',
                ),
              ],
            ),
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DetailIconText(
                  icon: Icons.check_circle_outline,
                  text: grading,
                ),
                DetailIconText(
                  icon: Icons.chat,
                  text: 'Chat with Dr',
                ),
              ],
            ),
            SizedBox(height: 30),

            // Table for Marks
            Container(
              decoration: BoxDecoration(
                color: Colors.blue.shade100,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Table(
                border: TableBorder.all(color: Colors.blue),
                columnWidths: const <int, TableColumnWidth>{
                  0: FlexColumnWidth(),
                  1: FlexColumnWidth(),
                  2: FlexColumnWidth(),
                  3: FlexColumnWidth(),
                },
                children: [
                  TableRow(
                    decoration: BoxDecoration(
                      color: color.primaryColor,
                    ),
                    children: [
                      TableCell(
                          child: Center(
                              child: Padding(
                        padding: REdgeInsets.all(8.0),
                        child: Text('Midterm',
                            style: TextStyle(color: Colors.white)),
                      ))),
                      TableCell(
                          child: Center(
                              child: Padding(
                        padding: REdgeInsets.all(8.0),
                        child:
                            Text('Oral', style: TextStyle(color: Colors.white)),
                      ))),
                      TableCell(
                          child: Center(
                              child: Padding(
                        padding: REdgeInsets.all(8.0),
                        child: Text('Final Exam',
                            style: TextStyle(
                              color: Colors.white,
                            )),
                      ))),
                      TableCell(
                          child: Center(
                              child: Padding(
                        padding: REdgeInsets.all(8.0),
                        child: Text('Total Marks',
                            style: TextStyle(color: Colors.white)),
                      ))),
                    ],
                  ),
                  for (var mark in marks)
                    TableRow(children: [
                      TableCell(
                          child: Center(
                              child: Padding(
                        padding: REdgeInsets.all(25.0),
                        child: Text(
                          mark['Midterm']!,
                          style: TextStyle(
                              fontSize: 20.sp, color: color.primaryColor),
                        ),
                      ))),
                      TableCell(
                          child: Center(
                              child: Padding(
                        padding: REdgeInsets.all(25.0),
                        child: Text(mark['Oral']!,
                            style: TextStyle(
                                fontSize: 20.sp, color: color.primaryColor)),
                      ))),
                      TableCell(
                          child: Center(
                              child: Padding(
                        padding: REdgeInsets.all(25.0),
                        child: Text(mark['Final Exam']!,
                            style: TextStyle(
                                fontSize: 20.sp, color: color.primaryColor)),
                      ))),
                      TableCell(
                          child: Center(
                              child: Padding(
                        padding: REdgeInsets.all(25.0),
                        child: Text(mark['Total Marks']!,
                            style: TextStyle(
                                fontSize: 20.sp, color: color.primaryColor)),
                      ))),
                    ]),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DetailIconText extends StatelessWidget {
  final IconData icon;
  final String text;

  DetailIconText({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: Colors.blue,
        ),
        SizedBox(width: 8),
        Text(
          text,
          style: TextStyle(
            color: Colors.black87,
            fontSize: 15.sp,
          ),
        ),
      ],
    );
  }
}
