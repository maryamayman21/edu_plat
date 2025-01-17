import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/utils/Color/color.dart';
typedef Validator = String? Function(String?);
class CustomTextfield extends StatelessWidget {
  const CustomTextfield({super.key, this.controller, required this.hintText, required this.label,  this.keyboardType = TextInputType.text, required this.validator, this.isObscure = false});
  final TextEditingController? controller;
  final String hintText;
  final String label;
  final TextInputType keyboardType;
  final bool isObscure;
  final Validator validator;
  @override
  Widget build(BuildContext context) {
    return
       Padding(
         padding:  EdgeInsets.symmetric(vertical: 15.h),
         child: TextFormField(
          controller: controller,
          keyboardType: keyboardType,
         obscureText: isObscure,
          validator: validator,
           autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: InputDecoration(
            labelText: label,
            hintText:  hintText,
            labelStyle: const TextStyle(
              color: Colors.black
            ),
            hintStyle: const TextStyle(
              color: Colors.grey
            ) ,
            border: OutlineInputBorder(
              borderSide: const BorderSide(
                color: color.primaryColor
              ),
              borderRadius: BorderRadius.circular(10.0.r),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                  color: color.primaryColor
              ),
              borderRadius: BorderRadius.circular(10.0.r),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                  color: color.primaryColor
              ),
              borderRadius: BorderRadius.circular(10.0.r),
            ),
               ),
             ),
       );
  }
}
