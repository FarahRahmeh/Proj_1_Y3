import 'package:booktaste/common/widgets/layouts/grid_layout.dart';
import 'package:booktaste/common/widgets/products/product_card/product_card_vertical.dart';
import 'package:booktaste/common/widgets/texts/section_heading.dart';
import 'package:booktaste/controllers/category/all_categories_controller.dart';
import 'package:booktaste/models/all_categories_model.dart';
import 'package:booktaste/user/user_all_books/all_books_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common/widgets/category/x_show_case.dart';
import '../../../utils/constans/images.dart';
import '../../../utils/constans/sizes.dart';
import '../../user_all_books/all_books_controller.dart';

// class CategoryTab extends StatelessWidget {
//   const CategoryTab({super.key, required this.category});
//   final AllCategories? category;
//   @override
//   Widget build(BuildContext context) {
//     final genreBooksCtrl = Get.put(AllCategoriesController());
//     genreBooksCtrl.fetchCategoryBooks(category!.id.toString());
//     return ListView(
//         physics: NeverScrollableScrollPhysics(),
//         shrinkWrap: true,
//         children: [
//           Padding(
//             padding: EdgeInsets.all(Sizes.defaultSpace),
//             child: Column(
//               children: [
//                 // ///Genres
//                 // XShowcase(
//                 //     images: [Images.cover1, Images.cover2, Images.cover7]),
//                 // SizedBox(
//                 //   height: Sizes.spaceBtwItems,
//                 // ),
//                 //Heading
//                 SectionHeading(
//                   title: 'You might like ',
//                   onPressed: () {},
//                 ),
//                 SizedBox(
//                   height: Sizes.spaceBtwItems,
//                 ),
//                 //Books
//                 Obx(() {
//                   if (genreBooksCtrl.isCaBooksLoading.value) {
//                     return Center(
//                         child: Image.asset(
//                       width: 90,
//                       Images.coffeeLoading,
//                     ));
//                   } else if (genreBooksCtrl.categoryBooks.isEmpty) {
//                     return Center(
//                       child: Text('data empty'),
//                     );
//                   } else {
//                     return MyGridLayout(
//                       itemCount: genreBooksCtrl.categoryBooks.length,
//                       itemBuilder: (_, index) => ProductCardVertical(
//                           allbooks: genreBooksCtrl.categoryBooks[index]),
//                       // ListTile(
//                       //   title: Text(genreBooksCtrl.categoryBooks[index].name),
//                       // ),
//                     );
//                   }
//                 }),
//                 SizedBox(
//                   height: Sizes.spaceBtwSections,
//                 ),
//               ],
//             ),
//           ),
//         ]);
//   }
// }
class CategoryTab extends StatelessWidget {
  const CategoryTab({super.key, required this.category});
  final AllCategories? category;

  @override
  Widget build(BuildContext context) {
    final genreBooksCtrl = Get.put(AllCategoriesController());

    return FutureBuilder<List<AllBooks?>?>(
      future: genreBooksCtrl.fetchCategoryBooks(category!.id.toString()),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error fetching data'));
        } else {
          final books = snapshot.data;
          if (books!.length == 0) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(Sizes.md),
                child: Column(
                  children: [
                    Text(
                      'No Books here..',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    Center(
                        child: Image.asset(
                      Images.onboarding_1,
                      height: 100,
                      width: 100,
                    )),
                  ],
                ),
              ),
            );
          }
          return MyGridLayout(
            itemCount: books!.length,
            itemBuilder: (_, index) => ProductCardVertical(
              allbooks: books[index],
            ),
          );
        }
      },
    );
  }
}
