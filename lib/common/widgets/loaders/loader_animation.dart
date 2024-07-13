import 'package:booktaste/utils/constans/images.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

/// A circular loader widget with customizable foreground and background colors.
class MyLoaderAnimation extends StatelessWidget {
  const MyLoaderAnimation({
    super.key,
    this.animatedImage = Images.defaultLoaderAnimation,
    this.height = 80,
    this.width = 80,
  });
  final String animatedImage;
  final double height, width;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Lottie.asset(
        animatedImage,
        height: height,
        width: width,
      ),
    );
  }
}
