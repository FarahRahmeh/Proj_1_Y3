import 'package:booktaste/utils/constans/colors.dart';
import 'package:booktaste/utils/constans/sizes.dart';
import 'package:booktaste/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class CircularIcon extends StatelessWidget {
  ///A custom circular Icon widget with a background color.
  ///
  ///properties :
  ///Container [size], [height], [backgroundColor].
  ///
  ///Icon's [size],[color] &[onPressed]

  const CircularIcon({
    super.key,
    this.width,
    this.height,
    this.size = Sizes.lg,
    required this.icon,
    this.color,
    this.backgroundColor,
    this.onPressed,
  });
  final double? width, height, size;
  final IconData icon;
  final Color? color;
  final Color? backgroundColor;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: backgroundColor != null
            ? backgroundColor!
            : HelperFunctions.isDarkMode(context)
                ? MyColors.white.withOpacity(0.2)
                : lightBrown.withOpacity(0.2),
      ),
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(
          icon,
          color: color,
          size: size,
        ),
      ),
    );
  }
}
