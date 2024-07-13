import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../../../utils/constans/colors.dart';
import '../../../utils/constans/sizes.dart';
import '../../../utils/helpers/helper_functions.dart';

class MyDropdownBtnFormField extends StatelessWidget {
  const MyDropdownBtnFormField({
    super.key,
    this.prefixIcon = Iconsax.sort_copy,
    required this.items,
    this.prefixIconColor = lightBrown,
    this.onChanged,
    this.hintText = 'Filter by',
    this.label = 'Label',
  });
  final IconData prefixIcon;
  final List<String> items;
  final Color prefixIconColor;
  final void Function(String?)? onChanged;
  final String hintText;
  final String label;
  @override
  Widget build(BuildContext context) {
    final dark = HelperFunctions.isDarkMode(context);

    return DropdownButtonFormField(
      dropdownColor: dark ? MyColors.darkestGrey : offWhite,
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(
            color: prefixIconColor,
          ),
        ),
        contentPadding: EdgeInsets.all(Sizes.md),
        hintText: hintText,
        hintStyle: TextStyle(
          color: dark ? offWhite : brown,
          //fontSize: Sizes.md,
        ),
        prefixIcon: Icon(
          prefixIcon,
          color: prefixIconColor,
        ),
      ),
      onChanged: onChanged,
      items: items
          .map((option) => DropdownMenuItem(
              value: option,
              child: Text(
                option,
                style: TextStyle(color: dark ? offWhite : brown),
              )))
          .toList(),
    );
  }
}
