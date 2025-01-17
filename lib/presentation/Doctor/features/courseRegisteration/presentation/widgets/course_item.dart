import 'dart:ui';
import 'package:flutter/material.dart';
import '../../../../../../core/utils/Assets/appAssets.dart';
import '../../../../../../core/utils/Color/color.dart';

class CourseItem extends StatelessWidget {
  const CourseItem({
    super.key,
    required this.courseCode,
    required this.isSelected,
    required this.onSelect,
  });

  final String courseCode;
  final bool isSelected;
  final VoidCallback onSelect;

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onSelect,
        child: Container(
          width: 200,
          height: 150,
          decoration: BoxDecoration(
            color: isSelected!  ? null : Colors.white,
            image: isSelected ?  const DecorationImage(
                image: AssetImage(
                  AppAssets.courseBackground,
                ),
                fit: BoxFit.fill) : null,
            boxShadow:  isSelected ?  [
              BoxShadow(
                color: color.primaryColor.withOpacity(0.4), // Shadow color
                //  spreadRadius: 2, // Spread radius
                blurRadius: 7, // Blur radius
                offset: const Offset(
                    0, 10), // Shadow position (horizontal, vertical)
              ),
            ] :  [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2), // Shadow color
                //  spreadRadius: 2, // Spread radius
                blurRadius: 3, // Blur radius
                offset: const Offset(
                    0, 5), // Shadow position (horizontal, vertical)
              ),
            ] ,
            borderRadius: const BorderRadius.all(Radius.circular(30)),
            border: Border.all(color: isSelected? Colors.white : Colors.grey.withOpacity(0.4) , width: isSelected? 3 : 1)
          ),
          child: Center(
            child: Text(courseCode,
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    letterSpacing: 1,
                    fontFamily: 'Roboto-Mono',
                    color: isSelected ?  Colors.white : color.primaryColor,
                    fontSize: 25,
                    fontWeight: FontWeight.bold)),
          ),
        ));
  }
}

