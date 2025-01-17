import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/utils/Color/color.dart';

class CategoryItem extends StatelessWidget {
  const CategoryItem({super.key, required this.imagePath, required this.categoryName, required this.onTap});
 final String imagePath;
 final String categoryName;
 final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return  InkWell(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        height: 200,
        width: double.infinity,
        decoration:  BoxDecoration(
          color: color.primaryColor,
          borderRadius: BorderRadius.all(Radius.circular(15.r))
        ),
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(imagePath, height: 120.0.h,),
              Text(categoryName,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: Colors.white,
                fontSize: 25,
                fontWeight: FontWeight.w500
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
