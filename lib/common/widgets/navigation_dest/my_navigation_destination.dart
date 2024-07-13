import 'package:flutter/material.dart';

import '../../../utils/constans/colors.dart';
import '../../../utils/helpers/helper_functions.dart';

class MyNavigationDestination extends StatelessWidget {
  const MyNavigationDestination(
      {super.key,
      required this.icon,
      this.iconColorDark = offWhite,
      this.iconColorLight = lightBrown,
      required this.label,
      required this.selectedIcon});

  final IconData icon;
  final Color iconColorLight;
  final Color iconColorDark;
  final String label;
  final IconData selectedIcon;

  @override
  Widget build(BuildContext context) {
    final dark = HelperFunctions.isDarkMode(context);

    return NavigationDestination(
      icon: Icon(
        icon,
        color: dark ? iconColorDark : iconColorLight,
      ),
      label: label,
      selectedIcon: Icon(
        selectedIcon,
        color: dark ? iconColorDark : iconColorLight,
      ),
    );
  }
}
