import 'package:flutter/material.dart';

void showLoadingDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false, // Prevent dismissing while loading
    builder: (context) => const AlertDialog(
      content: Row(
        children: [
          CircularProgressIndicator(),
          SizedBox(width: 20),
          Text('Loading...'),
        ],
      ),
    ),
  );
}

void showSuccessDialog(BuildContext context, {String message = 'Operation Successful!'}) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Success'),
      content: Text(message),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('OK'),
        ),
      ],
    ),
  );
}

void showErrorDialog(BuildContext context, {String message = 'Something went wrong!'}) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Error'),
      content: Text(message),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('OK'),
        ),
      ],
    ),
  );
}

Future<bool?> showConfirmDialog(BuildContext context, {String message = "Are you sure?"}) {
  return showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text("Confirm"),
      content: Text(message),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, false), // Cancel
          child: Text("Cancel"),
        ),
        ElevatedButton(
          onPressed: () => Navigator.pop(context, true), // Confirm
          child: Text("Confirm"),
        ),
      ],
    ),
  );
}