import 'package:booktaste/common/widgets/icons/circular_icon.dart';
import 'package:booktaste/utils/constans/colors.dart';
import 'package:booktaste/utils/constans/sizes.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../../../utils/helpers/helper_functions.dart';

class BottomAddToCart extends StatelessWidget {
  const BottomAddToCart({super.key, this.title = 'Add To Cart'});

  final String title;

  @override
  Widget build(BuildContext context) {
    final dark = HelperFunctions.isDarkMode(context);

    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: Sizes.defaultSpace, vertical: Sizes.defaultSpace / 2),
      decoration: BoxDecoration(
        color: dark ? MyColors.darkGrey : MyColors.light,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(Sizes.cardRadiusLg),
          topRight: Radius.circular(Sizes.cardRadiusLg),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
              //   children: [
              //     CircularIcon(
              //       icon: Iconsax.minus_copy,
              //       backgroundColor: gray,
              //       width: 40,
              //       height: 40,
              //       color: offWhite,
              //     ),
              //     SizedBox(
              //       width: Sizes.spaceBtwItems,
              //     ),
              //     Text(
              //       '2',
              //       style: Theme.of(context).textTheme.titleSmall,
              //     ),
              //     const SizedBox(
              //       width: Sizes.spaceBtwItems,
              //     ),
              //     CircularIcon(
              //       icon: Iconsax.add_copy,
              //       backgroundColor: lightBrown,
              //       width: 40,
              //       height: 40,
              //       color: offWhite,
              //     ),
              //   ],
              ),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.all(Sizes.md),
              backgroundColor: lightBrown,
              side: BorderSide(color: beige2),
            ),
            child: Text(title),
          ),
        ],
      ),
    );
  }
}
