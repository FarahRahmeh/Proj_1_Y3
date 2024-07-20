import 'package:booktaste/common/widgets/appbar/appbar.dart';
import 'package:booktaste/common/widgets/images/rounded_image.dart';
import 'package:booktaste/common/widgets/texts/section_heading.dart';
import 'package:booktaste/models/all_categories_model.dart';
import 'package:booktaste/models/cafe_shelf_model.dart';
import 'package:booktaste/utils/constans/images.dart';
import 'package:booktaste/utils/constans/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../common/widgets/products/product_card/product_card_horizontal.dart';
import '../user_all_books/all_books_controller.dart';

class SubCategoriesPage extends StatelessWidget {
  const SubCategoriesPage({
    super.key,
    required this.genre,
    this.category,
    // this.shelf,
  });
  final String genre;
  //final CafeShelf? shelf;
  final AllCategories? category;

  @override
  Widget build(BuildContext context) {
    String genree = genre.toUpperCase();
    final allbookscontroller = Get.find<AllBooksController>();

    return Scaffold(
      appBar: MyAppBar(
        title: Text(genree),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(Sizes.defaultSpace),
          child: Column(
            children: [
              ///Banner
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RoundedImage(
                    // imageUrl: Images.promoBanner,
                    isNetworkImage: category == null ? false : true,
                    imageUrl: category == null
                        ? Images.onboarding_1
                        : category!.image,
                    shHeight: 100,
                    shWidth: 100,
                    height: 100,
                    applyImageRadius: false,
                  ),
                ],
              ),
              SizedBox(
                height: Sizes.spaceBtwSections,
              ),

              ///Sub-Categries
              Column(
                children: [
                  SectionHeading(
                    title: '$genre books',
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
