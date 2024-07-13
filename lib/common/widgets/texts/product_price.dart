import 'package:flutter/material.dart';

import '../../../utils/constans/colors.dart';

class ProductPriceText extends StatelessWidget {
  const ProductPriceText({
    super.key,
    // this.currencySign = '\$',
    required this.title,
    // this.maxLines = 1,
    // this.isLarge = false,
    // this.lineThrough = false,
    this.color = brown,
  });
  final String title;
  final Color color;
  // final String currencySign;
  // final int maxLines;
  // final bool isLarge;
  // final bool lineThrough;
  @override
  Widget build(BuildContext context) {
    return Text(
        // currencySign +
        title,
        overflow: TextOverflow.ellipsis,
        // maxLines: maxLines,
        // style: isLarge
        style: Theme.of(context)
            .textTheme
            .bodyMedium!
            .apply(color: color, fontWeightDelta: 1) //headlinesnmall
        // ? Theme.of(context).textTheme.headlineMedium!.apply(
        //     decoration: lineThrough ? TextDecoration.lineThrough : null)
        // : Theme.of(context).textTheme.titleLarge!.apply(
        //     decoration: lineThrough ? TextDecoration.lineThrough : null)
        );
  }
}
