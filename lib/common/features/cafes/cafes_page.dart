import 'dart:convert';

import 'package:booktaste/common/widgets/appbar/appbar.dart';
import 'package:booktaste/common/widgets/layouts/grid_layout.dart';
import 'package:booktaste/common/widgets/products/product_card/product_card_vertical.dart';
import 'package:booktaste/common/widgets/texts/section_heading.dart';
import 'package:booktaste/controllers/cafe/cafes_controller.dart';
import 'package:booktaste/models/cafe_model.dart';
import 'package:booktaste/models/cafe_shelf_model.dart';
import 'package:booktaste/user/user_all_books/all_books_controller.dart';
import 'package:booktaste/user/user_sub_category/sub_categories_page.dart';
import 'package:booktaste/utils/constans/colors.dart';
import 'package:booktaste/utils/constans/images.dart';
import 'package:booktaste/utils/constans/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:read_more_text/read_more_text.dart';

import '../../widgets/category/x_card.dart';
import '../../widgets/custom_shapes/stack/stack_image_with_widget.dart';
import '../../../controllers/cafe/cafe_shelves_controller.dart';

class CafePage extends StatelessWidget {
  final String cafeId;
  final Cafe? cafe;
  CafePage({super.key, required this.cafeId, required this.cafe});

  @override
  Widget build(BuildContext context) {
    final cafeShelvesCtrl = Get.put(CafeShelvesController());
    // final allbookscontroller = Get.find<AllBooksController>();
    final cafeBooksCtrl = Get.put(CafesController());
    cafeBooksCtrl.fetchCafeBooks(cafeId);
    print('Cafe id in cafe page' + cafeId);
    return Scaffold(
      //backgroundColor: gray,
      //!Appbar
      appBar: MyAppBar(
        showBackArrow: true,
        title: Text(
          cafe!.name + ' Café ',
        ),
        //! Search
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Iconsax.search_normal_copy,
            ),
          )
        ],
      ),
      //!Body
      body: FutureBuilder<List<CafeShelf?>?>(
        future: cafeShelvesCtrl.fetchCafeShelves(cafeId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            print('stoped waiting cafe shelves');
            return Center(
                child: Image.asset(
              width: 110,
              Images.coffeeLoading,
            ));
          } else if (snapshot.hasError) {
            print('Error cafe shelves: ${snapshot.error}');
            return Center(
              child: Text('Error cafe shelves: ${snapshot.error}'),
            );
          } else if (snapshot.hasData) {
            List<CafeShelf?> shelves = snapshot.data!;
            cafeShelvesCtrl.cafeShelvesList = shelves;

            print('there is data cafe shelves snapshot' +
                jsonEncode(shelves) +
                ' ///in controller// ' +
                jsonEncode(cafeShelvesCtrl.cafeShelvesList));

            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(Sizes.defaultSpace),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //!------------------------------
                    Column(
                      children: [
                        StackImageWithWidget(
                          isNetworkImg: true,
                          imageUrl: cafe!.image,
                          child: Container(
                            decoration: BoxDecoration(
                              color:
                                  // offWhite.withOpacity(0.5),
                                  MyColors.black.withOpacity(0.4),
                              gradient: gradients.last,
                              borderRadius: BorderRadius.circular(Sizes.md),
                            ),
                            padding: EdgeInsets.symmetric(
                                horizontal: Sizes.sm, vertical: Sizes.md),
                            width: double.infinity,
                            child: ReadMoreText(
                              cafe!
                                  .bio, //'Join our virtual reading cafés where every page turns into a conversation get ready to sip chat and read your virtual reading café experience starts here! Ready to bookmark your next escape? Lets begin! '
                              numLines: 10,
                              readMoreText: 'Show more',
                              readLessText: 'Less',
                              readMoreIconColor: offWhite,
                              readMoreTextStyle:
                                  TextStyle(color: offWhite.withOpacity(0.8)),
                              style: TextStyle(
                                  color: offWhite,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 14),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: Sizes.spaceBtwSections / 2),
                    MyGridLayout(
                      mainAxisExtent: 80, //80 for xCard , 120 for CafeGenreCard
                      itemCount: cafeShelvesCtrl.cafeShelvesList.length,
                      itemBuilder: (_, index) {
                        CafeShelf? cafeShelf;
                        cafeShelf = cafeShelvesCtrl.cafeShelvesList[index];
                        return XCard(
                          isNetworkImage: true,
                          image: cafeShelf!.image,
                          onTap: () => Get.to(() => SubCategoriesPage(
                              shelf: cafeShelf,
                              genre: cafeShelf!.genre.toString())),
                          title: cafeShelf!.genre.toString(),
                          subTitle:
                              'cafeId:${cafeShelf!.cafeId}id ${cafeShelf!.id}',
                        );
                      },
                    ),
                    SizedBox(height: Sizes.spaceBtwSections / 2),
                    SectionHeading(
                      title: 'Cafe Books',
                      showActionButton: false,
                    ),

                    Obx(() {
                      if (cafeBooksCtrl.isBooksLoading.value) {
                        return Center(
                            child: Image.asset(
                          width: 90,
                          Images.coffeeLoading,
                        ));
                      } else if (cafeBooksCtrl.cafeBooks.isEmpty) {
                        return Center(
                          child: Text('data empty'),
                        );
                      } else {
                        return MyGridLayout(
                          itemCount: cafeBooksCtrl.cafeBooks.length,
                          itemBuilder: (_, index) => ProductCardVertical(
                              bookk: cafeBooksCtrl.cafeBooks[index]),
                          // ListTile(
                          //   title: Text(genreBooksCtrl.categoryBooks[index].name),
                          // ),
                        );
                      }
                    }),
                  ],
                ),
              ),
            );
          } else {
            print('the else cafe shelves');
            return Center(
                child: Image.asset(
              width: 110,
              Images.coffeeLoading,
            ));
          }
        },
      ),
    );
  }
}
