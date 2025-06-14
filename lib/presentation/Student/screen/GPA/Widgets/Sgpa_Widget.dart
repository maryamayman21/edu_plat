import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SgpaWidget extends StatefulWidget {
  final TextEditingController controller;
  final Color textColor;
  final bool allowDecimal;
  const SgpaWidget({required this.controller,required this.textColor,  this.allowDecimal=false});

  @override
  State<SgpaWidget> createState() => _SgpaWidgetState();

  static bool _isNumeric(String str, bool allowDecimal) {
    final numericRegex = allowDecimal
        ? RegExp(r'^\d*\.?\d*$') // يسمح بالفاصلة العشرية
        : RegExp(r'^\d*$');      // أرقام صحيحة فقط
    return numericRegex.hasMatch(str);
  }
}

class _SgpaWidgetState extends State<SgpaWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: widget.controller,
          keyboardType: TextInputType.number,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
            color: widget.textColor,
          ),
          decoration: InputDecoration(
            hintText: "00",
            hintStyle: TextStyle(color: widget.textColor.withOpacity(0.5)),
            border: InputBorder.none,
          ),
          onChanged: (value) {
            if (!SgpaWidget._isNumeric(value, widget.allowDecimal)) {
              widget.controller.text = value.replaceAll(
                widget.allowDecimal ? RegExp(r'[^0-9.]') : RegExp(r'[^0-9]'),
                '',
              );
              widget.controller.selection = TextSelection.fromPosition(
                TextPosition(offset: widget.controller.text.length),
              );
            }
          },
    ),
      ],
    );
  }
}
