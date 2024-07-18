// import 'package:booktaste/common/widgets/shimmers/category_shimmer.dart';
// import 'package:booktaste/user/user_home/all_categories_model.dart';
// import 'package:booktaste/user/user_sub_category/sub_categories_page.dart';
// import 'package:booktaste/utils/constans/colors.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// import '../../../common/widgets/image_with_text/vertical_image_text.dart';
// import '../../../controllers/category/all_categories_controller.dart';
// import '../../../utils/constans/images.dart';
// import '../user_home_controller.dart';

// class UserHomeCategories extends StatelessWidget {
//   // final allcategoriescontroller =
//   //     Get.put(AllCategoriesController(), permanent: true);
//   UserHomeCategories({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final allcategoriescontroller = Get.find<AllCategoriesController>();
//     return SizedBox(
//       height: 80,
//       child: Obx(() {
//         if (allcategoriescontroller.isLoading.value) {
//           return CategoryShimmer(
//             itemCount: allcategoriescontroller.allCategoriesList.length,
//           );
//         } else {
//           return ListView.builder(
//             shrinkWrap: true,
//             itemCount: allcategoriescontroller.allCategoriesList.length,
//             scrollDirection: Axis.horizontal,
//             itemBuilder: (context, index) {
//               var image =
//                   allcategoriescontroller.allCategoriesList[index].genre;
//               // return
//               //  VerticalImageWithText(
//               //   categories: allcategoriescontroller.allCategoriesList[index],
//               //   //image: Images.book,

//               //   // title: "all" ,
//               //   onTap: () => Get.to(() => SubCategoriesPage(
//               //         genre: allcategoriescontroller
//               //             .allCategoriesList[index].genre,
//               //       )),
//               //   // textColor: , //~------------same color
//               // );
//             },
//           );
//         }
//       }),
//     );
//   }
// }
