import 'package:booktaste/common/widgets/custom_shapes/Containers/rounded_container.dart';
import 'package:booktaste/utils/constans/colors.dart';
import 'package:booktaste/utils/constans/sizes.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../../../../utils/helpers/helper_functions.dart';

class SingleAddress extends StatelessWidget {
  const SingleAddress({super.key, required this.selectedAddress});
  final bool selectedAddress;
  @override
  Widget build(BuildContext context) {
    final dark = HelperFunctions.isDarkMode(context);

    return RoundedContainer(
      width: double.infinity,
      padding: EdgeInsets.all(Sizes.md),
      showBorder: true,
      backgroundColor: selectedAddress
          ? MyColors.primary.withOpacity(0.5)
          : Colors.transparent,
      borderColor: selectedAddress
          ? Colors.transparent
          : dark
              ? MyColors.darkGrey
              : gray,
      margin: EdgeInsets.only(bottom: Sizes.spaceBtwItems),
      child: Stack(
        children: [
          Positioned(
            right: 5,
            top: 0,
            child: Icon(
              selectedAddress ? Iconsax.tick_circle : null,
              color: selectedAddress
                  ? dark
                      ? MyColors.light
                      : MyColors.dark.withOpacity(0.5)
                  : null,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Whatever Name ',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              SizedBox(
                height: Sizes.sm / 2,
              ),
              Text(
                'Whatever phone number here',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(
                height: Sizes.sm / 2,
              ),
              Text(
                'Whatever address here .... ',
                maxLines: 2,
                softWrap: true,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
