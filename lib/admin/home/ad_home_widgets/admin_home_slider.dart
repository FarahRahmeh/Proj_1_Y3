// import 'dart:ffi';

// import 'package:booktaste/common/widgets/images/circular_image.dart';
// import 'package:booktaste/controllers/cafe/cafe_shelves_controller.dart';
// import 'package:booktaste/controllers/cafe/cafes_controller.dart';
// import 'package:booktaste/data/repositories/cafes_repository.dart';
// import 'package:booktaste/models/cafe_model.dart';
// import 'package:booktaste/models/cafe_shelf_model.dart';
// import 'package:booktaste/common/features/cafes/cafes_page.dart';
// import 'package:booktaste/user/user_home/user_home_controller.dart';
// import 'package:booktaste/user/user_home/user_home_widgets/cafe_slider.dart';
// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// import '../../../common/widgets/custom_shapes/Containers/circular_container.dart';
// import '../../../common/widgets/images/rounded_image.dart';
// import '../../../utils/constans/colors.dart';
// import '../../../utils/constans/images.dart';
// import '../../../utils/constans/sizes.dart';
// import '../../../utils/helpers/helper_functions.dart';
// import '../admin_cafes/admin_cafes_page.dart';

// class AdminPromoSlider extends StatelessWidget {
//   const AdminPromoSlider({
//     super.key,
//     required this.banners,
//   });

//   final List<String> banners;

//   @override
//   Widget build(BuildContext context) {
//     final controller = Get.put(UserHomeController());
//     final cafescontroller = Get.find<CafesController>();

//     final dark = HelperFunctions.isDarkMode(context);
//     final CafeShelf cafeShelf = CafeShelf();

//     return Column(
//       children: [
//         Obx(
//           () {
//             if (cafescontroller.isLoading.value) {
//               return Center(
//                   child: Image.asset(
//                 width: 90,
//                 Images.coffeeLoading,
//               ));
//             } else {
//               return SizedBox(
//                 height: 200,
//                 child: ListView.builder(
//                   shrinkWrap: true,
//                   itemCount: cafescontroller.cafesList.length,
//                   scrollDirection: Axis.horizontal,
//                   itemBuilder: (context, index) {
//                     cafeShelf.cafeId = cafescontroller.cafesList[index].id;

//                     return GestureDetector(
//                       onTap: () {
//                         // Get.to(
//                         //     () => AdminCafe(
//                         //           cafeId: cafeShelf.cafeId,
//                         //         ),
//                         //     arguments: cafescontroller.cafesList[index].id);
//                       },
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           SizedBox(
//                             height: 130,
//                             width: 180,
//                             child: RoundedImage(

//                                 // applyImageRadius: true,
//                                 fit: BoxFit.contain,
//                                 imageUrl: Images.book,
//                                 //  imageUrl: Image.network(),
//                                 //   backgroundColor: brown,
//                                 //  imageUrl: banners[index],
//                                 title: cafescontroller.cafesList[index].name),
//                           ),
//                           // // RoundedImage(imageUrl:cafescontroller.cafesList[index].image),
//                           SizedBox(
//                             // width: 55,
//                             child: Padding(
//                               padding: const EdgeInsets.only(
//                                   top: Sizes.xs, left: Sizes.xs),
//                               child: Text(
//                                 cafescontroller.cafesList[index].name,
//                                 style: Theme.of(context)
//                                     .textTheme
//                                     .headlineSmall!
//                                     .apply(
//                                         color: dark
//                                             ? lightBrown
//                                             : brown), //~------------color
//                                 maxLines: 1,
//                                 overflow: TextOverflow.ellipsis,
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     );
//                   },
//                 ),
//               );
//             }
//           },
//         ),
//         // //! Stack

//         //     Obx(
//         //       () =>
//         //           // Stack(
//         //           //   //   index: controller.carousalCurrentIndex.value,
//         //           //   children: [
//         //           CarouselSlider(
//         //         options: CarouselOptions(
//         //             clipBehavior: Clip.none,
//         //             viewportFraction: 1,
//         //             onPageChanged: (index, _) {
//         //               return controller.updatePageIndicator(index);
//         //             }),
//         //         items: banners.map((url) {
//         //           int index = banners.indexOf(url);
//         //           return CafeSlider(
//         //             // isNetworkImage: true,
//         //             width: 300,
//         //             imageUrl: url,
//         //             title: cafescontroller.cafesList[index].name,
//         //           );
//         //         }).toList(),
//         //       ),
//         //       // SizedBox(
//         //       //   // width: 55,
//         //       //   child: Text(
//         //       //     cafescontroller.cafesList[].name,
//         //       //     style: Theme.of(context)
//         //       //         .textTheme
//         //       //         .labelMedium!
//         //       //         .apply(color: brown), //~------------color
//         //       //     maxLines: 1,
//         //       //     overflow: TextOverflow.ellipsis,
//         //       //   ),
//         //       // ),
//         //       //   ],
//         //       // ),
//         //     ),
//         //     const SizedBox(
//         //       height: Sizes.spaceBtwItems,
//         //     ),
//         //     Center(
//         //       child: Obx(() => Row(
//         //             mainAxisSize: MainAxisSize.min,
//         //             children: [
//         //               for (int i = 0; i < cafescontroller.cafesList.length; i++)
//         //                 Column(
//         //                   children: [
//         //                     CircularContainer(
//         //                       margin: const EdgeInsets.only(right: 10),
//         //                       width: 20,
//         //                       height: 4,
//         //                       backgroundColor:
//         //                           controller.carousalCurrentIndex.value == i
//         //                               ? brown
//         //                               : gray,
//         //                     ),
//         //                   ],
//         //                 ),
//         //             ],
//         //           )),
//         //     )
//       ],
//     );
//   }
// }
