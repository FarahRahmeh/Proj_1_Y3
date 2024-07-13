import 'package:booktaste/common/widgets/custom_shapes/Containers/rounded_container.dart';
import 'package:booktaste/common/widgets/texts/product_price.dart';
import 'package:booktaste/common/widgets/texts/product_title.dart';
import 'package:booktaste/common/widgets/texts/section_heading.dart';
import 'package:booktaste/utils/constans/colors.dart';
import 'package:booktaste/utils/constans/sizes.dart';
import 'package:flutter/material.dart';
import '../../../common/widgets/choice_chip/my_choice_chip.dart';
import '../../../utils/helpers/helper_functions.dart';

class ProductAttributes extends StatelessWidget {
  const ProductAttributes({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = HelperFunctions.isDarkMode(context);

    return Column(
      children: [
        /// !-- Selected Attribute Pricing & Description
        RoundedContainer(
          padding: const EdgeInsets.all(Sizes.md),
          backgroundColor: dark ? MyColors.darkGrey : gray,
          child: Column(
            children: [
              //Title , Price and Stock Staus
              Row(
                children: [
                  const SectionHeading(
                    title: 'Variation',
                    showActionButton: false,
                  ),
                  const SizedBox(
                    width: Sizes.spaceBtwItems,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const ProductTitleText(
                            title: 'Price  :',
                            smallSize: true,
                          ),

                          //Actual Price
                          Text(
                            '\$25',
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .apply(decoration: TextDecoration.lineThrough),
                          ),
                          const SizedBox(
                            width: Sizes.spaceBtwItems,
                          ),

                          //Sale Price
                          ProductPriceText(title: '20'),
                        ],
                      ),
                      Row(
                        children: [
                          const ProductTitleText(
                            title: 'Stack  :',
                            smallSize: true,
                          ),
                          Text(
                            'In Stack',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              //Variation Description
              const ProductTitleText(
                title:
                    'This is the description of the product it can be up to max 4 lines.......................................',
                smallSize: true,
                maxLines: 4,
              ),
            ],
          ),
        ),
        const SizedBox(
          height: Sizes.spaceBtwItems,
        ),

        //!---Attirbutes
        /// Colors
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SectionHeading(
              title: 'Color',
              showActionButton: false,
            ),
            SizedBox(
              height: Sizes.spaceBtwItems / 2,
            ),
            Wrap(
              spacing: 8,
              children: [
                MyChoiceChip(
                  text: 'Green',
                  selected: false,
                  onSelected: (value) {},
                ),
                MyChoiceChip(
                    text: 'Red', selected: true, onSelected: (value) {}),
                MyChoiceChip(
                    text: 'Black', selected: false, onSelected: (value) {}),
              ],
            )
          ],
        ),

        /// Sizes
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SectionHeading(
              title: 'Size',
              showActionButton: false,
            ),
            SizedBox(
              height: Sizes.spaceBtwItems / 2,
            ),
            Wrap(
              spacing: 8,
              children: [
                MyChoiceChip(
                  text: '36',
                  selected: false,
                  onSelected: (value) {},
                ),
                MyChoiceChip(
                    text: '37', selected: true, onSelected: (value) {}),
                MyChoiceChip(
                    text: '40', selected: false, onSelected: (value) {}),
              ],
            )
          ],
        ),
      ],
    );
  }
}
