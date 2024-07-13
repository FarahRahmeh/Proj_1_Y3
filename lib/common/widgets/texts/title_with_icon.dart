import 'package:booktaste/utils/constans/colors.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../../../utils/constans/enums.dart';
import '../../../utils/constans/sizes.dart';
import 'x_title_text.dart';

class TextTitleWithIcon extends StatelessWidget {
  const TextTitleWithIcon({
    super.key,
    required this.title,
    this.maxLines = 1,
    this.textColor = brown,
    this.iconColor = MyColors.primary,
    this.textAlign = TextAlign.center,
    this.titleTextSize = TextSizes.small,
  });
  final String title;
  final int maxLines;
  final Color? textColor, iconColor;
  final TextAlign? textAlign;
  final TextSizes titleTextSize;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          child: XTitleText(
            title: title,
            color: textColor,
            maxLines: maxLines,
            textAlign: textAlign,
            xTextSize: titleTextSize,
          ),
        ),
        SizedBox(width: Sizes.xs),
        Icon(Iconsax.path_copy, color: iconColor, size: Sizes.iconXs),
      ],
    );
  }
}
