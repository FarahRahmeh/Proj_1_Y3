import 'package:booktaste/utils/constans/images.dart';
import 'package:flutter/material.dart';

import '../../images/rounded_image.dart';

class StackImageWithWidget extends StatelessWidget {
  const StackImageWithWidget({
    super.key,
    this.alignment = Alignment.topLeft,
    this.boxFit = BoxFit.cover,
    this.isNetworkImg = false,
    this.imgaeWidth = double.infinity,
    this.imageHeight = 230,
    this.imageUrl = Images.cover2,
    required this.child,
  });
  final double imageHeight, imgaeWidth;
  final BoxFit boxFit;
  final String imageUrl;
  final bool isNetworkImg;
  final Alignment alignment;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        RoundedImage(
          isNetworkImage: isNetworkImg,
          height: imageHeight,
          fit: boxFit,
          imageUrl: imageUrl,
          width: imgaeWidth,
          applyImageRadius: true,
        ),
        Align(alignment: alignment, child: child),
      ],
    );
  }
}
