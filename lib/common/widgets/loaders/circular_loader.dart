import 'package:booktaste/utils/constans/colors.dart';
import 'package:flutter/material.dart';

import '../../../utils/constans/sizes.dart';

/// A circular loader widget with customizable foreground and background colors.
class CircularLoader extends StatelessWidget {
  /// Default constructor for the CircularLoader.
  ///
  /// Parameters:
  ///   - foregroundColor: The color of the circular loader.
  ///   - backgroundColor: The background color of the circular loader.
  const CircularLoader({
    super.key,
    this.foregroundColor = MyColors.white,
    this.backgroundColor = MyColors.secondary,
  });

  final Color? foregroundColor;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(Sizes.lg),
      decoration: BoxDecoration(color: backgroundColor, shape: BoxShape.circle),
      child: Center(
        child: CircularProgressIndicator(
            color: foregroundColor, backgroundColor: Colors.transparent),
      ),
    );
  }
}
