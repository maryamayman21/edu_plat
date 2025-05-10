import 'package:edu_platt/core/utils/Color/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TableMark extends StatelessWidget {
  const TableMark({super.key, required this.marks});
  final Map<String, dynamic> marks; // Single map of marks

  @override
  Widget build(BuildContext context) {
    // Extract keys and values from the map
    final processedMarks = processGrading(marks);
    final keys = processedMarks.keys.toList();
    final values = processedMarks.values.toList();

    return Container(
      decoration: BoxDecoration(
        color:  color.primaryColor,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Table(
        border: TableBorder.all(color: Colors.white),
        columnWidths: _generateColumnWidths(keys.length), // Dynamic column widths
        children: [
          // Header row (dynamic based on map keys)
          TableRow(
            decoration:  BoxDecoration(
              color: Colors.deepPurpleAccent[50], // Header background color
            ),
            children: keys.map((key) {
              return TableCell(
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 20.w),
                    child: Text(
                      key, // Display the key (e.g., 'Mid', 'Oral')
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
          // Data row (dynamic based on map values)
          TableRow(
            children: values.map((value) {
              return TableCell(
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.all(20.0.w),
                    child: Text(
                      value.toString(), // Display the value (e.g., 120, 30)
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  // Generate column widths dynamically based on the number of keys
  Map<int, TableColumnWidth> _generateColumnWidths(int columnCount) {
    return Map<int, TableColumnWidth>.fromIterable(
      List<int>.generate(columnCount, (index) => index),
      value: (index) => const FlexColumnWidth(),
    );
  }
  Map<String, dynamic> processGrading(Map<String, dynamic> grading) {
    // Create a mapping for key renaming
    final keyMapping = {
      'midTerm': 'Mid Term',
      'oral': 'Oral',
      'totalMark': 'Total Mark',
      'lab': 'Lab',
      'finalExam': 'Final Exam',
    };

    // Initialize an empty map for the processed grading
    final processedGrading = <String, dynamic>{};

    // Iterate over the original grading map
    grading.forEach((key, value) {
      // Rename the key using the mapping
      final readableKey = keyMapping[key] ?? key;

      // Check if the key is 'lab' and its value is 0
      if (key == 'lab' && value == 0) {
        return; // Skip adding this key-value pair to the processed grading
      }

      // Add the key-value pair to the processed grading map
      processedGrading[readableKey] = value;
    });

    return processedGrading;
  }

}