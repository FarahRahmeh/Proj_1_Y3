import 'package:booktaste/common/widgets/shimmers/shimmer.dart';
import 'package:booktaste/utils/constans/sizes.dart';
import 'package:flutter/material.dart';

class CafesShimmer extends StatelessWidget {
  const CafesShimmer({
    Key? key,
    this.itemCount = 7,
  }) : super(key: key);
  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: ListView.separated(
        shrinkWrap: true,
        itemCount: itemCount,
        scrollDirection: Axis.horizontal,
        separatorBuilder: (_, __) => const SizedBox(width: Sizes.spaceBtwItems),
        itemBuilder: (_, __) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              /// Image
              ShimmerEffect(width: 200, height: 150, radius: 20),
              SizedBox(height: Sizes.xs),

              /// Text
              ShimmerEffect(width: 180, height: 16),
            ],
          );
        },
      ),
    );
  }
}
