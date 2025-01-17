import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/utils/Color/color.dart';
typedef Validator = String? Function(String?);
class PasswordTextfield extends StatelessWidget {
  const PasswordTextfield({super.key, required this.hintText, required this.label, this.keyboardType =  TextInputType.text, required this.isObscure, required this.validator, this.onChanged, required this.suffixIcon, });
  final void Function(String)? onChanged;
  final String hintText;
  final String label;
  final TextInputType keyboardType;
  final bool isObscure;
  final Widget suffixIcon;

  final Validator validator;
  @override
  Widget build(BuildContext context) {
    return
       TextFormField(
         onChanged:onChanged ,
        keyboardType: keyboardType,
        obscureText: isObscure,
        validator: validator,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        decoration: InputDecoration(
          suffixIcon: suffixIcon,
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
            borderSide:  const BorderSide(
                color: color.primaryColor
            ),
            borderRadius: BorderRadius.circular(10.0.r),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
                color: color.primaryColor
            ),
            borderRadius: BorderRadius.circular(10.r),
          ),
        ),
    );
  }
}
