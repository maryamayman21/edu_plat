import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CreditWidget extends StatefulWidget {
  final String selectedHour;
  final ValueChanged<String> onChanged;
   CreditWidget({required this.selectedHour,required this.onChanged});

  @override
  State<CreditWidget> createState() => _CreditWidgetState();
}

class _CreditWidgetState extends State<CreditWidget> {
  final List<String> hours = ["1","2","3","4"];

  @override

  Widget build(BuildContext context) {
    return  Container(
      child: DropdownButton<String>(
        value: widget.selectedHour,
        items: hours.map((String grade) {
          return DropdownMenuItem<String>(
            value: grade,
            child: Text(
              grade,
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                color: Colors.pinkAccent,
              ),
            ),
          );
        }).toList(),
        onChanged: (String? newValue) {
          if (newValue != null) {
            widget.onChanged(newValue);
          }
        },
        icon: Padding(
          padding: REdgeInsets.only(left: 20.0),
          child: Icon(Icons.arrow_drop_down, color: Colors.pinkAccent, size: 30.sp),
        ),
      ),

    );
  }
}
