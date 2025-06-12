import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddOptionButton extends StatelessWidget {
  final VoidCallback onAddOption;
 final bool isWrittenExam;
  const AddOptionButton({super.key, required this.onAddOption, required this.isWrittenExam});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onAddOption,
      child: Text(
       isWrittenExam ? '+ Add question': '+ Add Option',
        style: TextStyle(fontSize: 16.sp), // Responsive font size
      ),
    );
  }
}