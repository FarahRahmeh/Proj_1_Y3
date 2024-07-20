import 'package:booktaste/common/widgets/shimmers/shimmer.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../../../utils/constans/api_constans.dart';

class MyNetworkImage extends StatelessWidget {
  const MyNetworkImage(
      {super.key,
      required this.shWidth,
      required this.shHeight,
      required this.notFoundImage,
      required this.imageUrl,
      this.fit});

  final double shWidth, shHeight;
  final String notFoundImage;
  final String imageUrl;
  final BoxFit? fit;
  @override
  Widget build(BuildContext context) {
    return imageUrl == '/' || imageUrl.isEmpty
        ? Center(child: Image(image: AssetImage(notFoundImage)))
        : CachedNetworkImage(
            fit: BoxFit.cover,
            imageUrl: Uri.parse(baseImageUrl).resolve(imageUrl).toString(),
            errorWidget: (context, url, error) {
              print(error.toString() + 'error in netowrk image');
              return SizedBox(
                width: 20,
                height: 20,
                child: Center(child: Icon(Iconsax.warning_2_copy)),
              );
            },
            progressIndicatorBuilder: (context, url, progress) => Center(
              child: ShimmerEffect(
                height: shHeight,
                width: shWidth,
              ),
            ),
          );
  }
}
