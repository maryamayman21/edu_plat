import 'package:flutter/material.dart';

class NavigationHelper {
  static void navigateWithAnimation(BuildContext context, Widget targetPage) {
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => targetPage,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const beginOffset = Offset(1.0, 0.0); // الحركة تبدأ من الأسفل
          const endOffset = Offset.zero;
          const curve = Curves.easeInOut;

          var offsetAnimation = Tween(begin: beginOffset, end: endOffset)
              .chain(CurveTween(curve: curve))
              .animate(animation);

          var scaleAnimation =
              Tween<double>(begin: 0.9, end: 1.0).animate(animation);

          return SlideTransition(
            position: offsetAnimation,
            child: ScaleTransition(
              scale: scaleAnimation,
              child: FadeTransition(
                opacity: animation,
                child: child,
              ),
            ),
          );
        },
        transitionDuration:
            const Duration(milliseconds: 700), // التحكم في سرعة الحركة
      ),
    );
  }
}
