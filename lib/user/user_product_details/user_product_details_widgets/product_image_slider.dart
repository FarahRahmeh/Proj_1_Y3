import 'package:booktaste/common/widgets/images/network_image.dart';
import 'package:booktaste/common/widgets/shimmers/shimmer.dart';
import 'package:booktaste/data/repositories/book_repository.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../../../data/services/role.manager.dart';
import '../../../utils/constans/api_constans.dart';
import '../../../utils/constans/colors.dart';
import '../../../utils/constans/images.dart';
import '../../../utils/constans/sizes.dart';
import '../../../utils/helpers/helper_functions.dart';
import '../../../common/widgets/appbar/appbar.dart';
import '../../../common/widgets/custom_shapes/curved_edges/curved_edge_widget.dart';
import '../../../common/widgets/icons/circular_icon.dart';
import '../../../common/widgets/images/rounded_image.dart';

class ProductImageSlider extends StatelessWidget {
  const ProductImageSlider({
    super.key,
    required this.imageurl,
  });
  final String imageurl;
  @override
  Widget build(BuildContext context) {
    final dark = HelperFunctions.isDarkMode(context);
    return CurvedEdgeWidget(
      child: Container(
        color: dark ? MyColors.darkestGrey : MyColors.light,
        child: Stack(
          children: [
            ///! Main large image
            SizedBox(
              height: 400,
              child: Padding(
                padding: EdgeInsets.all(Sizes.productImageRadius * 2),
                child: Center(
                    child: MyNetworkImage(
                  imageUrl: imageurl,
                  notFoundImage: Images.defaultBookCover,
                  fit: BoxFit.cover,
                  shHeight: 380,
                  shWidth: 210,
                )
                    // imageurl == '/'
                    //     ? Center(child: Icon(Iconsax.warning_2_copy))
                    //     : CachedNetworkImage(
                    //         imageUrl: '$baseImageUrl$imageurl',
                    //         errorWidget: (context, url, error) =>
                    //             Icon(Iconsax.warning_2_copy),
                    //         progressIndicatorBuilder: (context, url, progress) =>
                    //             Center(
                    //           child: ShimmerEffect(
                    //             height: 230,
                    //             width: 200,
                    //           ),
                    //         ),
                    //       ),

                    ),
              ),
            ),

            ///! Image Slider
            // Positioned(
            //   right: 0,
            //   bottom: 40,
            //   left: Sizes.defaultSpace,
            //   child: SizedBox(
            //     height: 80,
            //     child: ListView.separated(
            //       shrinkWrap: true,
            //       scrollDirection: Axis.horizontal,
            //       physics: const AlwaysScrollableScrollPhysics(),
            //       itemCount: 5,
            //       separatorBuilder: (_, __) => SizedBox(
            //         width: Sizes.spaceBtwItems,
            //       ),
            //       itemBuilder: (_, index) => RoundedImage(
            //           width: 80,
            //           border: Border.all(color: beige2),
            //           padding: EdgeInsets.all(Sizes.sm),
            //           backgroundColor:
            //               dark ? Colors.transparent : MyColors.white,
            //           imageUrl: Images.cover4),
            //     ),
            //   ),
            // ),

            ///! Appbar
            MyAppBar(
              showBackArrow: true,
              actions: [
                FutureBuilder<bool>(
                  future: isUser(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator(); // or any other placeholder widget
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      final role = snapshot.data;
                      return role == true
                          ? Padding(
                              padding: const EdgeInsets.all(Sizes.sm),
                              child: CircularIcon(
                                icon: Iconsax.heart,
                                color: pinkish,
                              ),
                            )
                          : SizedBox.shrink();
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
