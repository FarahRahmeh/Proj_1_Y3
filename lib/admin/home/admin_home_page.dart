import 'package:booktaste/common/widgets/custom_shapes/Containers/primary_header_container.dart';
import 'package:booktaste/common/widgets/layouts/grid_layout.dart';
import 'package:booktaste/common/widgets/products/product_card/product_card_vertical.dart';
import 'package:booktaste/controllers/cafe/cafes_controller.dart';
import 'package:booktaste/user/user_all_books/all_books_controller.dart';
import 'package:booktaste/utils/constans/images.dart';
import 'package:booktaste/utils/constans/sizes.dart';
import 'package:booktaste/utils/constans/texts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../common/features/books/all_books_with_filter_page.dart';
import '../../common/features/cafes/cafes_home_slider.dart';
import '../../common/widgets/custom_shapes/Containers/search_container.dart';
import '../../common/widgets/texts/section_heading.dart';
import 'ad_home_widgets/admin_home_appbar.dart';
import '../../common/features/categories/home_categories.dart';

class AdminHomePage extends StatelessWidget {
  AdminHomePage({super.key});

  final allbookscontroller = Get.put(AllBooksController());
  final cafescontroller = Get.put(CafesController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      ///!Heading
      child: Column(
        children: [
          PrimaryHeaderContainer(
            height: 390,
            child: Column(
              children: [
                ///!Appbar
                AdminHomePageAppbar(),

                const SizedBox(
                  height: Sizes.spaceBtwSections,
                ),

                ///!Searchbar
                ///todo here should be a Row to add the "ADD Book" button
                SearchContainer(
                  text: Texts.homeSearchTitle,
                ),
                const SizedBox(
                  height: Sizes.spaceBtwSections,
                ),

                ///! ---Categories Section--
                Padding(
                  padding: EdgeInsets.only(left: Sizes.defaultSpace),
                  child: Column(
                    children: [
                      ///---Heading
                      SectionHeading(
                        title: 'Categories', //~------------ same color
                        showActionButton: false,
                      ),
                      const SizedBox(
                        height: Sizes.spaceBtwItems / 2,
                      ),

                      ///!---Categories List
                      HomeCategories(), //--->inside here //~------------ same color
                    ],
                  ),
                ),

                ///Cafes
                ///.....
              ],
            ),
          ),

          ///! Body
          const Padding(
            padding: EdgeInsets.only(left: Sizes.defaultSpace),
            child: SectionHeading(
              title: 'Cafés',
              showActionButton: false,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(Sizes.md), //Sizes.defultSpace
            child: Column(
              children: [
                ///! Cafes Slider
                CafesSlider(),

                const SizedBox(height: Sizes.sm
                    // Sizes.spaceBtwSections / 2,
                    ),
                // Center(
                //     child: Image.asset(
                //   width: 90,
                //   Images.coffeeLoading,
                // )),

                //! Heading
                SectionHeading(
                  title: 'Popular Books',
                  onPressed: () {
                    Get.to(() => AllBooksWithFilter());
                  },
                ),
                SizedBox(
                  height: Sizes.spaceBtwItems,
                ),

                ///!Popular products
                Obx(() {
                  if (cafescontroller.isLoading.value) {
                    return Center(
                        child: Image.asset(
                      width: 90,
                      Images.coffeeLoading,
                    ));
                  } else {
                    return MyGridLayout(
                      itemCount: allbookscontroller.booksList.length,
                      itemBuilder: (_, index) => ProductCardVertical(
                        bookk: allbookscontroller.booksList[index],
                      ),
                    );
                  }
                }),
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
