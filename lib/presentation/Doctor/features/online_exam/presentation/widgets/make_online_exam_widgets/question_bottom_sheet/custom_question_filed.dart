import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomQuestionField extends StatelessWidget {
  const CustomQuestionField({
    super.key,
    required this.hintText,
    this.validator,
    required this.value,
    required this.labelText,
    required this.onChanged,
    this.keyboardType, required this.isCourseCode,
  });

  final String hintText;
  final String value;
  final String labelText;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
 // final void Function()? onChanged;
  final void Function(String)? onChanged;
  final bool isCourseCode;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 5.w), // Responsive padding
      child: TextFormField(
        initialValue: isCourseCode? value.toUpperCase() : value,
        keyboardType: keyboardType,
        onChanged: onChanged,
        validator: validator,
        decoration: InputDecoration(
          hintStyle: TextStyle(
            fontSize: 16.sp, // Responsive font size
            fontWeight: FontWeight.w400,
            color: Colors.grey, // Adjust color as needed
            fontStyle: FontStyle.italic, // Optional
          ),
          labelStyle:TextStyle(
          fontSize: 16.sp, // Responsive font size
          fontWeight: FontWeight.w400,
          color:Theme.of(context).primaryColor.withOpacity(0.9), // Adjust color as needed
          fontStyle: FontStyle.italic, // Optional
        ),
          labelText: labelText,
          filled: true,
          fillColor: Colors.grey.shade200,
          hintText: hintText,
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey.shade200,
            ),
            borderRadius: BorderRadius.circular(10.r), // Responsive border radius
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey.shade200,
            ),
            borderRadius: BorderRadius.circular(10.r), // Responsive border radius
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey.shade200,
            ),
            borderRadius: BorderRadius.circular(10.r), // Responsive border radius
          ),
        ),
      ),
    );
  }
}