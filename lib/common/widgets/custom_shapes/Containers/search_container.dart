import 'package:booktaste/controllers/book/book_controller.dart';
import 'package:booktaste/user/user_all_books/all_books_controller.dart';
import 'package:booktaste/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../../../../utils/constans/colors.dart';
import '../../../../utils/constans/sizes.dart';
import '../../../../utils/device/device_utility.dart';
import '../../../search/search_page.dart';
import '../../products/product_card/product_card_vertical.dart';

class SearchContainer extends StatelessWidget {
  SearchContainer({
    super.key,
    required this.text,
    this.icon = Iconsax.search_normal_1_copy,
    this.showBackground = true,
    this.showBorder = true,
    this.padding = const EdgeInsets.symmetric(horizontal: Sizes.defaultSpace),
  });

  final String text;
  final IconData? icon;
  final bool showBackground, showBorder;
  final EdgeInsetsGeometry padding;
  final allBooksControlle = Get.put(BookDetailsController());
  // final BookDetailsController booksController = Get.find();
  final AllBooksController allBooksController = Get.find();

  @override
  Widget build(BuildContext context) {
    final dark = HelperFunctions.isDarkMode(context);
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.all(10),
            child: Container(
              width: DeviceUtils.getScreenWidth(context),
              height: 75,
              padding: const EdgeInsets.all(Sizes.md),
              decoration: BoxDecoration(
                color: showBackground
                    ? dark
                        ? MyColors.dark
                        : MyColors.light
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(Sizes.cardRadiusLg),
                border: showBorder
                    ? Border.all(color: dark ? lightBrown : gray)
                    : null,
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: showBackground
                      ? dark
                          ? MyColors.dark
                          : MyColors.light
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(Sizes.cardRadiusLg),
                  border: showBorder
                      ? Border.all(color: dark ? lightBrown : gray)
                      : null,
                ),
                child: MaterialButton(
                  onPressed: () => Get.to(() => SearchPage()),
                  child: Row(
                    children: [
                      Icon(
                        Iconsax.search_normal_copy,
                        color: lightBrown,
                      ),
                      SizedBox(width: 20),
                      Text("Searsh"),
                    ],
                  ),
                ),
              ),
              // child: Row(
              //   children: [
              //     Expanded(
              //       child: MaterialButton(
              //         onPressed: () {Get.to(()=> SearchPage());},
              //         child: TextFormField(
              //           controller: allBooksController.searchController,
              //           decoration: InputDecoration(
              //             prefixIcon: Icon(Iconsax.search_normal),
              //             labelText: "Search",
              //             suffixIconColor: pinkish,
              //             // suffixIcon: IconButton(
              //             //   onPressed: () {
              //             //     allBooksController.clearSearch();
              //             //   },
              //             //   icon: Icon(Icons.close),
              //             // ),
              //           ),
              //           // onChanged: (value) {
              //           //   allBooksController.addSearchToList(value);
              //           // },
              //         ),
              //       ),
              //     ),
              //   ],
              // ),
            ),
          ),
          // Flexible(
          //   child: Obx(() {
          //     if (allBooksController.searchList.isEmpty) {
          //       return Center();
          //     } else {
          //       return ListView.builder(
          //         shrinkWrap: true,
          //         scrollDirection: Axis.horizontal,
          //         // physics: NeverScrollableScrollPhysics(),
          //         itemCount: allBooksController.searchList.length,
          //         itemBuilder: (_, index) {
          //           return ProductCardVertical(
          //             allbooks: allBooksController.searchList[index],
          //           );
          //         },
          //       );
          //     }
          //   }),
          // ),
        ],
      ),
    );
  }
}
