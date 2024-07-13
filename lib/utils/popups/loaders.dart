import 'package:booktaste/utils/constans/colors.dart';
import 'package:booktaste/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class Loaders {
  static hideSnackBar() =>
      ScaffoldMessenger.of(Get.context!).hideCurrentSnackBar();

  static customToast({required message}) {
    ScaffoldMessenger.of(Get.context!).showSnackBar(
      SnackBar(
        width: 500,
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 3),
        backgroundColor: Colors.transparent,
        content: Container(
          padding: const EdgeInsets.all(12.0),
          margin: const EdgeInsets.symmetric(horizontal: 30),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: HelperFunctions.isDarkMode(Get.context!)
                ? MyColors.darkestGrey.withOpacity(0.9)
                : gray.withOpacity(0.9),
          ),
          child: Center(
              child: Text(message,
                  style: Theme.of(Get.context!).textTheme.labelLarge)),
        ),
      ),
    );
  }

  static successSnackBar(
      {required title, message = '', duration = 3, icon = Iconsax.check}) {
    Get.snackbar(
      title,
      message,
      isDismissible: true,
      shouldIconPulse: true,
      colorText: darkBrown,
      backgroundColor: beige,
      snackPosition: SnackPosition.BOTTOM,
      duration: Duration(seconds: duration),
      margin: const EdgeInsets.all(10),
      icon: Icon(icon, color: darkBrown),
    );
  }

  static warningSnackBar({required title, message = ''}) {
    Get.snackbar(
      title,
      message,
      isDismissible: true,
      shouldIconPulse: true,
      colorText: darkBrown,
      backgroundColor: lightBrown,
      snackPosition: SnackPosition.BOTTOM,
      duration: Duration(seconds: 3),
      margin: const EdgeInsets.all(20),
      icon: const Icon(Iconsax.warning_2, color: darkBrown),
    );
  }

  static errorSnackBAr({required title, message = ''}) {
    Get.snackbar(
      title,
      message,
      isDismissible: true,
      shouldIconPulse: true,
      colorText: darkBrown,
      backgroundColor: pinkish,
      snackPosition: SnackPosition.BOTTOM,
      duration: Duration(seconds: 4),
      margin: const EdgeInsets.all(20),
      icon: const Icon(Iconsax.warning_2, color: darkBrown),
    );
  }
}
