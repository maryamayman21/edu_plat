import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'dialogButton.dart';
import '../Assets/appAssets.dart';
import '../Color/color.dart';

class CustomDialogs {
  // Confirmation Dialog
  static Future<bool?> showConfirmationDialog({
    required BuildContext context,
    required String title,
    required String content,
    String confirmText = "Confirm",
    String cancelText = "Cancel",
     required String imageUrl
  }) async {
    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Image.asset(imageUrl,
          height: 80,
          ),
          SizedBox(
            height: 15.h,
          ),
          Text(
            content,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ],
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomDialogButton(
              text: cancelText,
              backGroundColor: Colors.white,
              Context: context,
              foreGroundColor:  color.primaryColor,
              onPressed: () => Navigator.of(context).pop(false),
            ),
            CustomDialogButton(
              text: confirmText,
              backGroundColor: color.primaryColor,
              Context: context,
              foreGroundColor: Colors.white,
              onPressed: () => Navigator.of(context).pop(true),
            )
          ],
        ),


      ]
      )
    );
  }

  static Future<bool?> showDeletionDialog({
    required BuildContext context,
    required String title,
    required String content,
    String confirmText = "Delete",
    String cancelText = "Cancel",
  }) async {
    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(AppAssets.trashBin),
            Text(
              content,
              // style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              //     color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomDialogButton(
                text: 'Cancel',
                backGroundColor: Colors.white,
                Context: context,
                foreGroundColor: color.primaryColor,
                onPressed: () => Navigator.of(context).pop(false),
              ),
              CustomDialogButton(
                text: 'Delete',
                backGroundColor: Colors.red,
                Context: context,
                foreGroundColor: Colors.white,
                onPressed: () => Navigator.of(context).pop(true),
              )
            ],
          ),
        ],
      ),
    );
  }

  // Error Dialog
  static Future<void> showErrorDialog({
    required BuildContext context,
    required String title,
    required String message,
    String buttonText = "OK",
  }) async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            const Icon(Icons.error, color: Colors.red),
            const SizedBox(width: 8),
            Text(title),
          ],
        ),
        content: Text(message),
        actions: [
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(buttonText),
          ),
        ],
      ),
    );
  }

  // Success Dialog
  static Future<void> showSuccessDialog({
    required BuildContext context,
    required String title,
    required String message,
    String buttonText = "OK",
  }) async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
         content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            AppAssets.successMark,
            height: 80,
          ),
          SizedBox(
            height: 15.h,
          ),
          Text(
           message,
            // style: Theme.of(context).textTheme.bodyMedium!.copyWith(
            //     color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ],
      ),
        actions: [
          CustomDialogButton(
            text: buttonText,
            backGroundColor: color.primaryColor,
            Context: context,
            foreGroundColor: Colors.white,
            onPressed: () => Navigator.of(context).pop(true),
          )
        ],
      ),
    );
  }

  // Customizable Dialog
  static Future<void> showCustomDialog({
    required BuildContext context,
    required Widget title,
    required Widget content,
    List<Widget>? actions,
  }) async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: title,
        content: content,
        actions: actions,
      ),
    );
  }

  // Loading Dialog
  static Future<void> showLoadingDialog({
    required BuildContext context,
    String message = "Loading...",
  }) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Dialog(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircularProgressIndicator(),
              const SizedBox(width: 16),
              Text(message),
            ],
          ),
        ),
      ),
    );
  }

  // Information Dialog
  static Future<void> showInfoDialog({
    required BuildContext context,
    required String title,
    required String message,
    String buttonText = "OK",
  }) async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(buttonText),
          ),
        ],
      ),
    );
  }
}
