import 'package:flutter/material.dart';

import '../../../utils/constans/sizes.dart';

class MyGridLayout extends StatelessWidget {
  const MyGridLayout({
    super.key,
    required this.itemCount,
    required this.itemBuilder,
    this.mainAxisExtent = 250, //288
    this.crossAxisCount = 2,
    this.mainAxisSpacing = 4,
    this.padding = EdgeInsets.zero,
    // this.scrollDirection = Axis.vertical,
  });

  final int itemCount;
  final double? mainAxisExtent;
  final Widget? Function(BuildContext, int) itemBuilder;
  final int crossAxisCount;
  final double mainAxisSpacing;
  final EdgeInsetsGeometry? padding;
  // final Axis scrollDirection;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      // scrollDirection: scrollDirection,
      itemCount: itemCount,
      shrinkWrap: true,
      padding: padding,
      // padding: EdgeInsets.all(Sizes.md),
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        mainAxisSpacing: mainAxisSpacing,
        childAspectRatio: Sizes.gridViewSpacing,
        mainAxisExtent: mainAxisExtent,
      ),
      itemBuilder: itemBuilder,
    );
  }
}
