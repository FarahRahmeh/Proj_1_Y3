import 'package:flutter/material.dart';

import '../../../utils/constans/colors.dart';
import '../../../utils/helpers/helper_functions.dart';

class MyPopupMenuButton extends StatelessWidget {
  const MyPopupMenuButton({
    super.key,
    this.icon = Icons.more_vert,
    this.iconColor = offWhite,
    required this.menuItems,
  });

  final IconData icon;
  final Color iconColor;
  final List<PopupMenuEntry> menuItems;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      icon: Icon(
        icon,
        color: iconColor,
      ),
      itemBuilder: (context) => menuItems,
    );
  }
}

class MyPopupMenuOption {
  final String label;
  final IconData icon;
  final Color? iconColor;
  final VoidCallback onTap;

  MyPopupMenuOption({
    required this.label,
    required this.icon,
    required this.onTap,
    this.iconColor,
  });

  PopupMenuItem getMenuItem(BuildContext context) {
    final dark = HelperFunctions.isDarkMode(context);
    return PopupMenuItem(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Icon(
            icon,
            color: iconColor ?? (dark ? offWhite : lightBrown),
          ),
          Text(label),
        ],
      ),
      onTap: onTap,
    );
  }
}
//! example of the menuItems parameter 
//  menuItems: [
//                               MyPopupMenuOption(
//                                 label: 'Edit',
//                                 icon: Iconsax.edit_2_copy,
//                                 iconColor: dark ? offWhite : lightBrown,
//                                 onTap: () {
//                                   
//                                 },
//                               ).getMenuItem(context),
//                               MyPopupMenuOption(
//                                 label: 'Delete',
//                                 icon: Iconsax.trash_copy,
//                                 iconColor: dark ? brown : pinkishMore,
//                                 onTap: () {
//                                  
//                                 },
//                               ).getMenuItem(context),
//                             ],