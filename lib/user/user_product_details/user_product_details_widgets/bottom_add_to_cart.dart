import 'package:booktaste/utils/constans/colors.dart';
import 'package:booktaste/utils/constans/sizes.dart';
import 'package:flutter/material.dart';

import '../../../utils/helpers/helper_functions.dart';

class BottomAddToBtn extends StatelessWidget {
  const BottomAddToBtn(
      {super.key,
      this.title1 = 'Add To Cart',
      this.title2 = 'Add',
      this.titleRead = 'Read',
      this.twoBtns = false,
      this.onPressed1,
      this.onPressed2,
      this.threeBtns = false,
      this.oneBtn = false,
      this.onPressedRead});

  final String title1;
  final String title2;
  final String titleRead;
  final bool twoBtns;
  final bool oneBtn;
  final bool threeBtns;
  final VoidCallback? onPressed1;
  final VoidCallback? onPressed2;
  final VoidCallback? onPressedRead;

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
          Row(),
          if (threeBtns)
            Row(
              children: [
                BottomButton(onPressed: onPressed1, title: title1),
                SizedBox(width: Sizes.spaceBtwInputFields / 2),
                BottomButton(onPressed: onPressed2, title: title2),
                SizedBox(width: Sizes.spaceBtwInputFields / 2),
                BottomButton(onPressed: onPressedRead, title: titleRead),
              ],
            )
          else if (twoBtns)
            Row(
              children: [
                BottomButton(onPressed: onPressed1, title: title1),
                SizedBox(width: Sizes.spaceBtwInputFields / 2),
                BottomButton(onPressed: onPressedRead, title: titleRead),
              ],
            )
          else if (oneBtn)
            Row(
              children: [
                BottomButton(
                  onPressed: onPressed1,
                  title: title1,
                  width: 150,
                ),
              ],
            )
          else
            Row(
              children: [
                BottomButton(onPressed: onPressedRead, title: titleRead),
              ],
            )
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
    this.width = 100,
  });

  final VoidCallback? onPressed;
  final String title;
  final double width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
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
