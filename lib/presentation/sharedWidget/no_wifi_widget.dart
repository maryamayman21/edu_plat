import 'package:edu_platt/core/utils/Assets/appAssets.dart';
import 'package:edu_platt/presentation/sharedWidget/buttons/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class NoWifiWidget extends StatelessWidget {
  const NoWifiWidget({super.key,  required this.onPressed});
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(child: Image.asset(AppAssets.noInternetConnection,height: 250.h,)),
        CustomElevatedButton(
          onPressed: onPressed,
          text: 'Retry',
        )
      ],
    );
  }
}
