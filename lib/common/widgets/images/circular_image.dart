import 'dart:convert';

import 'package:booktaste/common/widgets/images/network_image.dart';
import 'package:booktaste/utils/constans/colors.dart';
import 'package:booktaste/utils/constans/images.dart';
import 'package:booktaste/utils/constans/sizes.dart';
import 'package:booktaste/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class CircularImage extends StatelessWidget {
  CircularImage({
    super.key,
    this.width = 56,
    this.height = 56,
    this.padding = Sizes.sm,
    this.fit = BoxFit.cover,
    required this.image,
    this.overlayColor,
    this.backgroundColor,
    this.isNetworkImg = false,
    this.showBorder = false,
  });

  final double width, height, padding;
  final BoxFit? fit;
  final String image;
  final Color? overlayColor;
  final Color? backgroundColor;
  final bool isNetworkImg;
  final bool showBorder;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        border: showBorder ? Border.all(color: brown) : null,
        color: backgroundColor ??
            (HelperFunctions.isDarkMode(context)
                ? MyColors.black
                : MyColors.white),
        borderRadius: BorderRadius.circular(100),
      ),
      child: Center(
        child: isNetworkImg
            ? MyNetworkImage(
                shWidth: width,
                shHeight: height,
                notFoundImage: Images.onboarding_1,
                imageUrl: image)
            : Image(fit: fit, color: overlayColor, image: AssetImage(image)),
      ),
    );
  }
}
