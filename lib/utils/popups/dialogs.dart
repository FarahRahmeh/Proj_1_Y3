import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyDialogs {
  static defaultDialog({
    required BuildContext context,
    String title = 'Removal Confirmation',
    Widget content = const Text(
        'Removing this data will delete all related data. Are you sure?'),
    String cancelText = 'Cancel',
    String confirmText = 'Remove',
    Function()? onCancel,
    Function()? onConfirm,
    bool showOnlyOnConfirm = false,
  }) {
    // Show a confirmation dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: content,
          actions: [
            if (!showOnlyOnConfirm)
              TextButton(
                onPressed: onCancel ?? () => Get.back(),
                child: Text(cancelText),
              ),
            TextButton(
              onPressed: onConfirm,
              child: Text(confirmText),
            ),
          ],
        );
      },
    );
  }
}
