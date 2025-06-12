import 'package:edu_platt/presentation/sharedWidget/buttons/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TextError extends StatelessWidget {
  const TextError({super.key, required this.onPressed,required this.errorMessage, this.white=false});
  final String errorMessage;
  final bool white;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Text( errorMessage ,
                  style: TextStyle(
                  fontSize: 18.sp, // Slightly smaller for better balance
                  fontWeight: FontWeight.bold,
                  color: white ?  Colors.white : Colors.grey.shade600
                  ),
              ),
            ),
            CustomElevatedButton(
              onPressed: onPressed,
              text: 'Retry',
            )
          ],
        );
  }
}
