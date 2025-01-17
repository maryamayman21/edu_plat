import 'package:flutter/material.dart';
class CourseTab extends StatelessWidget {
  const CourseTab({super.key, this.onPressed, required this.text, this.backgroundColor, this.foregroundColor});

  final void Function()? onPressed;
  final String text;
  final Color? backgroundColor;
  final Color? foregroundColor;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor,// White text color
        elevation: 5, // Shadow depth
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30), // Rounded corners
        ),
        padding: const EdgeInsets.symmetric(
            horizontal: 20, vertical: 12), // Button padding
      ),
      onPressed:onPressed,
      child :  Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15 , vertical:  1),
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 16, // Font size
              fontWeight: FontWeight.bold, // Font weight
            ),
          ),
        ),
      ),
    );
  }
}
