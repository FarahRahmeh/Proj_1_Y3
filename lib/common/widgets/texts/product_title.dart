import 'package:flutter/material.dart';

class ProductTitleText extends StatelessWidget {
  const ProductTitleText({
    super.key,
    required this.title,
    this.maxLines = 2,
    this.textAlign = TextAlign.left,
    this.smallSize = false,
    this.fontWeightDelta = 0,
  });

  final String title;
  final int maxLines;
  final bool smallSize;
  final TextAlign? textAlign;
  final int fontWeightDelta;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: smallSize
          ? Theme.of(context)
              .textTheme
              .labelLarge!
              .apply(fontWeightDelta: fontWeightDelta)
          : Theme.of(context)
              .textTheme
              .titleSmall!
              .apply(fontWeightDelta: fontWeightDelta),
      overflow: TextOverflow.ellipsis,
      maxLines: maxLines,
      textAlign: textAlign,
    );
  }
}
