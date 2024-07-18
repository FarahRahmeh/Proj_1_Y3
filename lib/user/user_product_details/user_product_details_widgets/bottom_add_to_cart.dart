import 'package:booktaste/common/widgets/icons/circular_icon.dart';
import 'package:booktaste/utils/constans/colors.dart';
import 'package:booktaste/utils/constans/sizes.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../../../utils/helpers/helper_functions.dart';

class BottomAddToBtn extends StatelessWidget {
  const BottomAddToBtn({
    super.key,
    this.title1 = 'Add To Cart',
    this.title2 = 'Add',
    this.twoBtns = false,
    this.onPressed1,
    this.onPressed2,
  });

  final String title1;
  final String title2;
  final bool twoBtns;
  final VoidCallback? onPressed1;
  final VoidCallback? onPressed2;

  @override
  Widget build(BuildContext context) {
    final dark = HelperFunctions.isDarkMode(context);

    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: Sizes.defaultSpace, vertical: Sizes.defaultSpace / 2),
      decoration: BoxDecoration(
        color: dark ? MyColors.darkestGrey : MyColors.light,
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
          twoBtns
              ? Row(
                  children: [
                    BottomButton(onPressed: onPressed1, title: title1),
                    SizedBox(width: Sizes.spaceBtwInputFields),
                    BottomButton(onPressed: onPressed2, title: title2),
                  ],
                )
              : BottomButton(onPressed: onPressed1, title: title1),
        ],
      ),
    );
  }
}

class BottomButton extends StatelessWidget {
  const BottomButton({
    super.key,
    required this.onPressed,
    required this.title,
  });

  final VoidCallback? onPressed;
  final String title;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.all(Sizes.md),
          backgroundColor: lightBrown,
          side: BorderSide(color: offWhite),
        ),
        child: Text(title),
      ),
    );
  }
}
