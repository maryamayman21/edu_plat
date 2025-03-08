import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomElevatedButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;

  const CustomElevatedButton({
    Key? key,
    required this.onPressed,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.green, // Blue background
        foregroundColor: Colors.white, // White text color
        padding:  EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h), // Padding
        textStyle: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.bold,
        ), // Text style
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.r), // Rounded corners
        ),
      ),
      child: Text(text),
    );
  }
}