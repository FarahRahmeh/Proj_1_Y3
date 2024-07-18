// import 'package:booktaste/common/widgets/appbar/appbar.dart';
// import 'package:booktaste/common/widgets/category/x_card.dart';
// import 'package:booktaste/common/widgets/custom_shapes/Containers/search_container.dart';
// import 'package:booktaste/common/widgets/layouts/grid_layout.dart';
// import 'package:booktaste/common/widgets/products/product_card/product_card_vertical.dart';
// import 'package:booktaste/common/widgets/texts/section_heading.dart';
// import 'package:booktaste/data/repositories/cafes_repository.dart';
// import 'package:booktaste/models/book.dart';
// import 'package:booktaste/models/cafe_shelf_model.dart';
// import 'package:booktaste/user/user_all_books/all_books_controller.dart';
// import 'package:booktaste/utils/constans/colors.dart';
// import 'package:booktaste/utils/constans/images.dart';
// import 'package:booktaste/utils/constans/sizes.dart';
// import 'package:booktaste/utils/helpers/helper_functions.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:iconsax_flutter/iconsax_flutter.dart';
// import 'package:read_more_text/read_more_text.dart';

// import '../../../common/widgets/custom_shapes/stack/stack_image_with_widget.dart';
// import '../../../controllers/cafe/cafe_shelves_controller.dart';
// import '../admin_sub_category/sub_categories_page.dart';

// class AdminCafe extends StatelessWidget {
//   final cafeId;
//   final numOfShelves;
//   AdminCafe({super.key, required this.cafeId, this.numOfShelves});

//   @override
//   Widget build(BuildContext context) {
//     final cafeShelvesCtrl = Get.find<CafeShelvesController>();
//     final allbookscontroller = Get.find<AllBooksController>();

//     return Scaffold(
//       //backgroundColor: gray,
//       //!Appbar
//       appBar: MyAppBar(
//         showBackArrow: true,
//         title: Text(
//           'Cafe Shelves',
//         ),
//         //! Search
//         actions: [
//           IconButton(
//             onPressed: () {},
//             icon: Icon(
//               Iconsax.search_normal_copy,
//             ),
//           )
//         ],
//       ),
//       //!Body
//       body: FutureBuilder<List<CafeShelf>?>(
//         future: CafesRepository.fetchCafeShelves(cafeId),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             print('stoped waiting cafe shelves');
//             return Center(
//                 child: Image.asset(
//               width: 110,
//               Images.coffeeLoading,
//             ));
//           } else if (snapshot.hasError) {
//             print('Error cafe shelves: ${snapshot.error}');
//             return Center(
//               child: Text('Error cafe shelves: ${snapshot.error}'),
//             );
//           } else if (snapshot.hasData) {
//             List<CafeShelf> shelves = snapshot.data!;
//             cafeShelvesCtrl.cafeShelvesList = shelves.obs;
//             print('there is data cafe shelves' +
//                 shelves.toString() +
//                 cafeShelvesCtrl.cafeShelvesList.toString());

//             return SingleChildScrollView(
//               child: Padding(
//                 padding: const EdgeInsets.all(Sizes.defaultSpace),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     StackImageWithWidget(
//                       child: Container(
//                         decoration: BoxDecoration(
//                           color:
//                               // offWhite.withOpacity(0.5),
//                               MyColors.black.withOpacity(0.4),
//                           gradient: gradients.last,
//                           borderRadius: BorderRadius.circular(Sizes.md),
//                         ),
//                         padding: EdgeInsets.symmetric(
//                             horizontal: Sizes.sm, vertical: Sizes.md),
//                         width: double.infinity,
//                         child: ReadMoreText(
//                           'Join our virtual reading cafés where every page turns into a conversation get ready to sip chat and read your virtual reading café experience starts here! Ready to bookmark your next escape? Lets begin! ',
//                           numLines: 10,
//                           readMoreText: 'Show more',
//                           readLessText: 'Less',
//                           readMoreIconColor: offWhite,
//                           readMoreTextStyle:
//                               TextStyle(color: offWhite.withOpacity(0.8)),
//                           style: TextStyle(
//                               color: offWhite,
//                               fontWeight: FontWeight.w700,
//                               fontSize: 14),
//                         ),
//                       ),
//                     ),
//                     SizedBox(height: Sizes.spaceBtwSections / 2),
//                     MyGridLayout(
//                         mainAxisExtent:
//                             80, //80 for xCard , 120 for CafeGenreCard
//                         itemCount: shelves.length,
//                         itemBuilder: (_, index) {
//                           return XCard(
//                             title: cafeShelvesCtrl.cafeShelvesList[index].genre
//                                 .toString(),
//                             subTitle:
//                                 'cafeId:${cafeShelvesCtrl.cafeShelvesList[index].cafeId}id ${cafeShelvesCtrl.cafeShelvesList[index].id}',
//                             //~ Here when we should add the navigator to chat when we make it ............................................................
//                             onTap: () => Get.to(() => AdminSubCategoriesPage(
//                                   book: Book(),
//                                   genre: cafeShelvesCtrl
//                                       .cafeShelvesList[index].genre
//                                       .toString(),
//                                 )),
//                           );
//                         }),
//                     SizedBox(height: Sizes.spaceBtwSections / 2),
//                     Obx(() {
//                       if (allbookscontroller.isLoading.value) {
//                         return Center(
//                             child: Image.asset(
//                           width: 110,
//                           Images.coffeeLoading,
//                         ));
//                       } else {
//                         return Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             SectionHeading(
//                               showActionButton: false,
//                               title: 'Cafe Books',
//                               //   onPressed: () => Get.to(() => AllBrandsPage()),
//                             ),
//                             const SizedBox(height: Sizes.spaceBtwItems / 1.5),
//                             MyGridLayout(
//                               itemCount: allbookscontroller.booksList.length,
//                               itemBuilder: (_, index) => ProductCardVertical(
//                                 allbooks: allbookscontroller.booksList[index],
//                               ),
//                             ),
//                           ],
//                         );
//                       }
//                     }),
//                   ],
//                 ),
//               ),
//             );
//           } else {
//             print('the else cafe shelves');
//             return Center(
//                 child: Image.asset(
//               width: 110,
//               Images.coffeeLoading,
//             ));
//           }
//         },
//       ),
//     );
//   }
// }
