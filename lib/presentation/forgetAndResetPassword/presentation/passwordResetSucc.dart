
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/utils/Assets/appAssets.dart';
import '../../Routes/custom_AppRoutes.dart';
import '../../sharedWidget/buttons/custom_button.dart';
class PasswordResetSuccess extends StatelessWidget {
  const PasswordResetSuccess({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 32.h, horizontal: 16.w),
        child: Column(
          children: <Widget>[
            const Spacer(
              flex: 2,
            ),
              Image.asset(AppAssets.passwordSuccess),
                   SizedBox(
                  height: 20.h,
                ),
              Text('Successful',
              style: Theme.of(context).textTheme.headlineMedium,
              ),
                SizedBox(
              height: 32.h,
            ),
            Text('Congratulations! Your password has been changed. Click continue to login.',
           //    maxLines: 2,
              textWidthBasis: TextWidthBasis.longestLine,
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                color: Colors.grey,
                fontSize: 18.sp
              ),
            ),
                SizedBox(
              height: 64.h,
            ),
            CustomButtonWidget(
              child: Text('Continue',
                style:  TextStyle(
                    color: Colors.white, fontSize: 20.sp
                    , fontFamily: 'Roboto-Mono'
                ),
              ),
              onPressed: (){
                Navigator.pushReplacementNamed(context, AppRouters.loginStudentRoute , arguments: false);
                ///TODO:: Navigation
              },
            ),
              const Spacer(
              flex: 3,
            ),

          ],
        ),
      )
    );
  }
}
