import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyDatePicker extends StatelessWidget {
  const MyDatePicker({super.key, this.onChanged, required this.date, this.mode});
  final void Function(DateTime?)? onChanged;
  final DateTime? date;
  final String? mode;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 10.h), // Responsive padding
      child: DateTimeFormField(
        initialValue: date,
        validator: (input) {
          if (input == null) {
            return 'Enter date';
          }
          return null;
        },
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(const Duration(days: 365)),
        decoration: InputDecoration(
          hintText: 'Enter date',
          hintStyle: TextStyle(
            fontSize: 14.sp, // Responsive font size
            fontWeight: FontWeight.w400,
            color: Colors.grey,
            fontStyle: FontStyle.italic,
          ),
          filled: true,
          fillColor: Colors.grey.shade200,
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey.shade200,
            ),
            borderRadius:
                BorderRadius.circular(8.r), // Responsive border radius
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey.shade200,
            ),
            borderRadius: BorderRadius.circular(8.r),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey.shade200,
            ),
            borderRadius: BorderRadius.circular(8.r),
          ),
          suffixIcon: Icon(Icons.calendar_today,
              color: Colors.blue, size: 20.r), // Responsive icon
          contentPadding: EdgeInsets.symmetric(
              vertical: 8.h, horizontal: 16.w),
          label: const Text('Date')// Responsive padding
        ),
        style: TextStyle(
          fontSize: 14.sp, // Responsive font size
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
        mode: mode == 'date' ? DateTimeFieldPickerMode.date :  DateTimeFieldPickerMode.dateAndTime,
        onChanged: onChanged,
        autovalidateMode: AutovalidateMode.onUserInteraction,
      ),
    );
  }
}
