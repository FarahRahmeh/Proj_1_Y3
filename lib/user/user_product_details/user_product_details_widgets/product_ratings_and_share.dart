import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:get/get.dart';

import '../../../utils/constans/sizes.dart';

class RatingsAndShare extends StatelessWidget {
  const RatingsAndShare({
    super.key,
    // required this.rate,
    required this.votersNum,
  });
  // final double rate;///////////////////////////////////////////
  final String votersNum;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Iconsax.star_1_copy, color: Colors.amber, size: 32),
        const SizedBox(width: Sizes.spaceBtwItems / 2),
        Text.rich(TextSpan(
          children: [
            // TextSpan(text: rate.toString(), style: Theme.of(context).textTheme.bodyLarge),
            TextSpan(text: ' ( $votersNum voters) '),
          ],
        )),
      ],
    );
  }
}
