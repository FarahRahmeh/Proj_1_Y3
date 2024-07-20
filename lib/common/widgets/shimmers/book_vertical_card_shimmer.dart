import 'package:booktaste/common/styles/shadows.dart';
import 'package:flutter/material.dart';
import 'package:booktaste/common/widgets/shimmers/shimmer.dart';
import 'package:booktaste/utils/constans/sizes.dart';

class ProductCardVerticalShimmer extends StatelessWidget {
  const ProductCardVerticalShimmer({
    Key? key,
    this.itemCount = 7,
  }) : super(key: key);
  
  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: itemCount,
      scrollDirection: Axis.vertical,
      separatorBuilder: (_, __) => const SizedBox(height: Sizes.spaceBtwItems),
      itemBuilder: (_, __) {
        return Container(
          margin: EdgeInsets.all(4),
          width: 160,
          //180
          decoration: BoxDecoration(
            boxShadow: [ShadowStyle.verticalProductShadow],
            border: Border.all(
                color: Colors.transparent), //Colors.transparent
            borderRadius: BorderRadius.circular(Sizes.productImageRadius),
            color: Colors.white,
          ),
          child: Column(
            children: [
              /// Image Shimmer
              ShimmerEffect(width: 160, height: 180, radius: 20),
              SizedBox(height: Sizes.xs),

              /// Title Shimmer
              ShimmerEffect(width: 140, height: 20),
              SizedBox(height: Sizes.xs),

              /// Author Shimmer
              ShimmerEffect(width: 100, height: 16),
              SizedBox(height: Sizes.xs),

              /// Rating Shimmer
              ShimmerEffect(width: 60, height: 16),
              SizedBox(height: Sizes.xs),

              /// Button Shimmer
              ShimmerEffect(width: 40, height: 40, radius: 10),
            ],
          ),
        );
      },
    );
  }
}
