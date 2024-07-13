import 'package:booktaste/common/widgets/custom_shapes/Containers/rounded_container.dart';
import 'package:booktaste/utils/constans/colors.dart';
import 'package:flutter/material.dart';

import '../../../utils/constans/enums.dart';
import '../../../utils/constans/images.dart';
import '../../../utils/constans/sizes.dart';
import '../../../utils/helpers/helper_functions.dart';
import '../images/circular_image.dart';
import '../texts/x_title_text.dart';

class CafeGenreCard extends StatelessWidget {
  const CafeGenreCard({
    super.key,
    this.showBorder = true,
    this.onTap,
    this.margin = 3, //4
    this.image = Images.onboarding_1,
    this.isNetworkImage = false,
    this.title = 'book',
    this.subTitle = 'blahh....',
  });
  final bool showBorder;
  final void Function()? onTap;
  final double margin;
  final String image;
  final bool isNetworkImage;
  final String title;
  final String subTitle;

  @override
  Widget build(BuildContext context) {
    final dark = HelperFunctions.isDarkMode(context);
    return GestureDetector(
      onTap: onTap,
      child: RoundedContainer(
        height: 500,
        borderColor: dark ? lightBrown : gray,
        margin: EdgeInsets.all(margin), //*  overflow Warning
        padding: const EdgeInsets.all(Sizes.sm),
        showBorder: showBorder,
        backgroundColor: Colors.transparent,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                //!--Icon to show all this genre books
                Flexible(
                  child: CircularImage(
                    image: image,
                    isNetworkImg: isNetworkImage,
                    backgroundColor: lightBrown,
                    //Colors.transparent,
                    // overlayColor: HelperFunctions.isDarkMode(context)
                    //     ? MyColors.black
                    //     : MyColors.white,
                  ),
                ),
                const SizedBox(width: Sizes.spaceBtwItems / 2),
                //! icon to redirect to this genre chat
                Flexible(
                  child: CircularImage(
                    image: image,
                    isNetworkImg: isNetworkImage,
                    backgroundColor: beige,
                    //Colors.transparent,
                    // overlayColor: HelperFunctions.isDarkMode(context)
                    //     ? MyColors.black
                    //     : MyColors.white,
                  ),
                ),
                // const SizedBox(width: Sizes.spaceBtwItems / 2),
              ],
            ),
            //--Text
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //! Genre Name
                      XTitleText(
                        title: title,
                        xTextSize: TextSizes.large,
                      ),
                      //! Genre summary or whatever
                      Text(
                        subTitle,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
