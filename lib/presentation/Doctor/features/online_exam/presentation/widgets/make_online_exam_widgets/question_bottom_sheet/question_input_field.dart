

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class QuestionInputField extends StatelessWidget {
  final TextEditingController controller;

  const QuestionInputField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (input) => input?.trim().isEmpty ?? true ? 'Enter valid question' : null,
      decoration: InputDecoration(
        hintText: 'Enter Question',
        hintStyle: TextStyle(
          fontSize: 16.sp, // Responsive font size
          fontWeight: FontWeight.w400,
          color: Colors.grey,
          fontStyle: FontStyle.italic,
        ),
        labelText: 'Enter Question',
      ),
    );
  }
}
