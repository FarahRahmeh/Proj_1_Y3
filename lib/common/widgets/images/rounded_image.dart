import 'package:booktaste/common/widgets/images/network_image.dart';
import 'package:booktaste/utils/constans/images.dart';
import 'package:flutter/material.dart';

import '../../../utils/constans/sizes.dart';

class RoundedImage extends StatelessWidget {
  const RoundedImage({
    super.key,
    this.width,
    this.height,
    required this.imageUrl,
    this.applyImageRadius = true,
    this.border,
    this.backgroundColor,
    this.fit = BoxFit.contain,
    this.padding,
    this.isNetworkImage = false,
    this.onPressed,
    this.borderRadius = Sizes.md,
    this.title = '',
    this.notFoundImage = Images.defaultBookCover,
    this.shHeight = 20,
    this.shWidth = 20,
  });

  final double? width, height;
  final String imageUrl;
  final bool applyImageRadius;
  final BoxBorder? border;
  final Color? backgroundColor;
  final BoxFit? fit;
  final EdgeInsetsGeometry? padding;
  final bool isNetworkImage;
  final VoidCallback? onPressed;
  final double borderRadius;
  final String title;
  final double shWidth, shHeight;
  final String notFoundImage;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: width,
        height: height,
        padding: padding,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius),
            border: border,
            color: backgroundColor),
        child: ClipRRect(
          borderRadius: applyImageRadius
              ? BorderRadius.circular(borderRadius)
              : BorderRadius.zero,
          child: isNetworkImage
              ? MyNetworkImage(
                  fit: fit,
                  shWidth: shWidth,
                  shHeight: shHeight,
                  notFoundImage: notFoundImage,
                  imageUrl: imageUrl)
              : Image(image: AssetImage(imageUrl), fit: fit),
        ),
      ),
    );
  }
}
