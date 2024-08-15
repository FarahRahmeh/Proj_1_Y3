import 'package:booktaste/utils/constans/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../../../controllers/theme/theme_controller.dart';

class ThemeSwitcherIcon extends StatelessWidget {
  ThemeSwitcherIcon({
    Key? key,
    this.iconColor = brown,
  }) : super(key: key);
  final themeController = Get.find<ThemeController>();
  
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Obx(() {
        IconData icon;
        if (themeController.themeMode.value == ThemeMode.dark) {
          icon = Iconsax.moon_copy;
        } else if (themeController.themeMode.value == ThemeMode.light) {
          icon = Iconsax.sun_1_copy;
        } else {
          icon = Iconsax.magicpen_copy;
        }

        return IconButton(
          icon: Icon(
            icon,
            color: iconColor,
          ),
          onPressed: themeController.toggleTheme,
        );
      }),
    );
  }
}
