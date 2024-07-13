import 'package:booktaste/utils/constans/sizes.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../../../utils/constans/colors.dart';
import '../custom_shapes/Containers/rounded_container.dart';

class LockedIcon extends StatelessWidget {
  const LockedIcon({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return RoundedContainer(
      radius: Sizes.md,
      backgroundColor: beige2.withOpacity(0.5),
      padding: const EdgeInsets.symmetric(
          horizontal: Sizes.sm / 2, vertical: Sizes.xs / 2),
      child: Icon(
        Iconsax.crown,
        color: Colors.amber,
        size: 18,
      ),
    );
  }
}
