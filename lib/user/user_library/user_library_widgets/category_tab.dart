import 'package:booktaste/common/widgets/layouts/grid_layout.dart';
import 'package:booktaste/common/widgets/products/product_card/product_card_vertical.dart';
import 'package:booktaste/common/widgets/texts/section_heading.dart';
import 'package:booktaste/models/all_categories_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common/widgets/category/x_show_case.dart';
import '../../../utils/constans/images.dart';
import '../../../utils/constans/sizes.dart';
import '../../user_all_books/all_books_controller.dart';

class CategoryTab extends StatelessWidget {
  const CategoryTab({super.key, required this.category, required this.cat});
  final String category;
  final AllCategories cat;

  @override
  Widget build(BuildContext context) {
    final allbookscontroller = Get.put(AllBooksController());
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
                  cat: cat,
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
                Obx(() {
                  return MyGridLayout(
                      itemCount: allbookscontroller.booksList.length,
                      itemBuilder: (_, index) => ProductCardVertical(
                            allbooks: allbookscontroller.booksList[index],
                          ));
                }),
                SizedBox(
                  height: Sizes.spaceBtwSections,
                ),
              ],
            ),
          ),
        ]);
  }
}
