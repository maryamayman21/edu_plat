import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TextError extends StatelessWidget {
  const TextError({super.key, required this.errorMessage});
  final String errorMessage;
  @override
  Widget build(BuildContext context) {
    return
        Center(
          child: Text( errorMessage ,
              style: TextStyle(
              fontSize: 18.sp, // Slightly smaller for better balance
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade600
              ),
          ),
        );
  }
}
