import 'package:flutter/material.dart';

class CustomDialogButton extends StatelessWidget {
  const CustomDialogButton({super.key, this.Context, this.backGroundColor, this.foreGroundColor, required this.text, this.onPressed});
  final Context ;
  final  Color?  backGroundColor;
  final  Color?  foreGroundColor;
  final String text;
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backGroundColor, // Red background
        foregroundColor:foreGroundColor, // White text color
        elevation: 5, // Shadow depth
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15), // Rounded corners
        ),
        padding: const EdgeInsets.symmetric(
            horizontal: 12, vertical: 12), // Button padding
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 16, // Font size
            fontWeight: FontWeight.bold, // Font weight
          ),
        ),
      ),
    );
  }
}
