import 'package:booktaste/common/widgets/appbar/appbar.dart';
import 'package:booktaste/common/widgets/images/rounded_image.dart';
import 'package:booktaste/common/widgets/texts/section_heading.dart';
import 'package:booktaste/models/all_categories_model.dart';
import 'package:booktaste/utils/constans/images.dart';
import 'package:booktaste/utils/constans/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common/widgets/products/product_card/product_card_horizontal.dart';
import '../../../user/user_all_books/all_books_controller.dart';

class AdminSubCategoriesPage extends StatelessWidget {
  const AdminSubCategoriesPage(
      {super.key, required this.genre, required this.category});
  final String genre;// ! this is already obtaining in category ...
  final AllCategories category;
  @override
  Widget build(BuildContext context) {
    String genree = genre.toUpperCase();
    final allbookscontroller = Get.find<AllBooksController>();

    return Scaffold(
      appBar: MyAppBar(
        title: Text(category.genre),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(Sizes.defaultSpace),
          child: Column(
            children: [
              ///Banner
              RoundedImage(
                imageUrl: Images.promoBanner,
                width: double.infinity,
                applyImageRadius: true,
              ),
              SizedBox(
                height: Sizes.spaceBtwSections,
              ),

              ///Sub-Categries
              Column(
                children: [
                  SectionHeading(
                    title: '$genree top books',
                    onPressed: () {},
                  ),
                  SizedBox(
                    height: Sizes.spaceBtwItems / 2,
                  ),
                  SizedBox(
                    height: 120,
                    child: ListView.separated(
                      itemCount: allbookscontroller.booksList.length,
                      scrollDirection: Axis.horizontal,
                      separatorBuilder: (context, index) => SizedBox(
                        width: Sizes.spaceBtwItems,
                      ),
                      itemBuilder: (context, index) => ProductCardHorizontal(
                          allbooks: allbookscontroller.booksList[index]),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
