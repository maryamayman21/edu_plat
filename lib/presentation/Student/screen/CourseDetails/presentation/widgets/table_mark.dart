import 'package:edu_platt/core/utils/Color/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TableMark extends StatelessWidget {
  const TableMark({super.key, required this.marks});
  final List<Map<String, int>> marks;

  @override
  Widget build(BuildContext context) {
    // Ensure the list is not empty
    if (marks.isEmpty) {
      return Center(child: Text('No marks available', style: TextStyle(fontSize: 16.sp)));
    }

    // Extract the keys from the first map to create the table headers dynamically
    final headers = marks.first.keys.toList();

    return Container(
      decoration: BoxDecoration(
        color: Colors.blue.shade100,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Table(
        border: TableBorder.all(color: Colors.white),
        columnWidths: _generateColumnWidths(headers.length),
        children: [
          // Create the header row dynamically
          TableRow(
            decoration: const BoxDecoration(
              color: color.primaryColor,
            ),
            children: headers.map((header) {
              return TableCell(
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.all(8.0.w),
                    child: Text(
                      header,
                      style: TextStyle(color: Colors.white, fontSize: 16.sp),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
          // Create the data rows dynamically
          for (var mark in marks)
            TableRow(
              children: headers.map((header) {
                return TableCell(
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.all(16.0.w),
                      child: Text(
                        mark[header].toString(),
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: color.primaryColor,
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

  // Generate column widths dynamically based on the number of columns
  Map<int, TableColumnWidth> _generateColumnWidths(int columnCount) {
    return Map<int, TableColumnWidth>.fromIterable(
      List<int>.generate(columnCount, (index) => index),
      value: (index) => const FlexColumnWidth(),
    );
  }
}