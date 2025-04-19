import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class ActionButton extends StatelessWidget {
  const ActionButton({super.key, this.onPressed, required this.text, this.backgroundColor, this.foregroundColor, this.iconData});
  final void Function()? onPressed;
  final String text;
  final Color? backgroundColor;
   final Color? foregroundColor;
   final IconData? iconData;
  @override
  Widget build(BuildContext context) {
    return   ElevatedButton(
        style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor,// White text color
        elevation: 5, // Shadow depth
        shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.r), // Rounded corners
    ),

        ),
    onPressed:onPressed,
    child :  Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
            text,
          style:  TextStyle(
            fontSize: 16.sp, // Font size
            fontWeight: FontWeight.bold, // Font weight
          ),
        ),
        SizedBox(width: 8.w), // Responsive spacing between text and icon
        Icon(
          iconData,
          color: Colors.white,
          size: 20.sp, // Responsive icon size
        ),
      ],
    ),
    );
  }
}
