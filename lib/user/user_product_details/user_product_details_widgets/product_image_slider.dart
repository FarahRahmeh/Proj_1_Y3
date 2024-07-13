import 'package:booktaste/data/repositories/book_repository.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

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
    BookRepository().getBookCover(imageurl); //!...........................
    return CurvedEdgeWidget(
      child: Container(
        color: dark ? MyColors.darkGrey : MyColors.light,
        child: Stack(
          children: [
            ///! Main large image
            SizedBox(
              height: 400,
              child: Padding(
                padding: EdgeInsets.all(Sizes.productImageRadius * 2),
                child: Center(
                  child: RoundedImage(
                    isNetworkImage: imageurl == '/' ? false : true,
                    //imageUrl: Images.cover6,
                    imageUrl: imageurl == '/'
                        ? Images.cover6
                        : '$baseUrl${imageurl}', //!................
                    // applyImageRadius: true,
                  ),
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
                CircularIcon(
                  icon: Iconsax.heart,
                  color: pinkish,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
