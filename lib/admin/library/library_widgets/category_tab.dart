import 'package:booktaste/common/widgets/layouts/grid_layout.dart';
import 'package:booktaste/common/widgets/products/product_card/product_card_vertical.dart';
import 'package:booktaste/common/widgets/texts/section_heading.dart';
import 'package:flutter/material.dart';

import '../../../common/widgets/category/x_show_case.dart';
import '../../../utils/constans/images.dart';
import '../../../utils/constans/sizes.dart';

class CategoryTab extends StatelessWidget {
  const CategoryTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        children: [
          Padding(
            padding: EdgeInsets.all(Sizes.defaultSpace),
            child: Column(
              children: [
                ///Genres
                XShowcase(
                    images: [Images.cover1, Images.cover2, Images.cover7]),
                SizedBox(
                  height: Sizes.spaceBtwItems,
                ),
                //Heading
                SectionHeading(
                  title: 'You might like ',
                  onPressed: () {},
                ),
                SizedBox(
                  height: Sizes.spaceBtwItems,
                ),
                //Books
                // MyGridLayout(
                //     itemCount: 4,
                //     itemBuilder: (_, index) => ProductCardVertical()),
                SizedBox(
                  height: Sizes.spaceBtwSections,
                ),
              ],
            ),
          ),
        ]);
  }
}
