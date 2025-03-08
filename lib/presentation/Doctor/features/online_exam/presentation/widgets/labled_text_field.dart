import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LabeledTextField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final String hintText;
  final TextInputType keyboardType;
  final Function(String)? onChanged;

  const LabeledTextField({
    super.key,
    required this.label,
    required this.controller,
    this.hintText = '',
    this.keyboardType = TextInputType.text,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w), // Responsive padding
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Label
          Text(
            label,
            style: TextStyle(
              fontSize: 18.sp, // Responsive font size
              fontWeight: FontWeight.w600,
              color: Colors.white, // White text
            ),
          ),
          SizedBox(width: 20.w), // Responsive spacing between label and text field
          // Text Field
          SizedBox(
            width: 80.w, // Responsive width for a small input field
            height: 40.h, // Responsive height for better proportions
            child: TextField(
              controller: controller,
              keyboardType: keyboardType,
              onSubmitted: onChanged,
              style: TextStyle(
                fontSize: 18.sp, // Responsive font size
                fontWeight: FontWeight.w600,
                color: Colors.blue, // Blue text
              ),
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(vertical: 8.h), // Responsive padding
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade400),
                  borderRadius: BorderRadius.circular(12.r), // Responsive border radius
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade400),
                  borderRadius: BorderRadius.circular(12.r), // Responsive border radius
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.blue, // Highlight color when focused
                    width: 2.w, // Responsive border width
                  ),
                  borderRadius: BorderRadius.circular(12.r), // Responsive border radius
                ),
                filled: true,
                fillColor: Colors.grey.shade100, // Light background
                hintText: hintText,
                hintStyle: TextStyle(
                  fontSize: 16.sp, // Responsive font size
                  color: Colors.grey, // Grey hint text
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}