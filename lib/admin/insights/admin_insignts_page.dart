import 'package:booktaste/common/widgets/shimmers/category_shimmer.dart';
import 'package:booktaste/models/all_categories_model.dart';
import 'package:booktaste/user/user_sub_category/sub_categories_page.dart';
import 'package:booktaste/utils/constans/api_constans.dart';
import 'package:booktaste/utils/constans/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/repositories/categories_repository.dart';
import '../../../utils/constans/sizes.dart';
import '../../../controllers/category/all_categories_controller.dart';
import '../../../utils/constans/images.dart';
import '../../../admin/home/admin_sub_category/sub_categories_page.dart';
import '../../common/widgets/appbar/appbar.dart';

class InsightsPage extends StatelessWidget {
  InsightsPage({super.key});
  //final allCategoriesController = Get.find<AllCategoriesController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: MyAppBar(
        //   title: Text('Insight'),
        // ),
        // body: SingleChildScrollView(
        //   child: Column(
        //     children: [
        //       SizedBox(
        //         height: 80,
        //         child: FutureBuilder<List<AllCategories?>?>(
        //           future: AllCategoriesRepository.fechAllCategories(),
        //           builder: (context, snapshot) {
        //             if (snapshot.connectionState == ConnectionState.waiting) {
        //               return CategoryShimmer(
        //                 itemCount:
        //                     allCategoriesController.allCategoriesList.length,
        //               );
        //             } else if (snapshot.hasError) {
        //               return Center(
        //                 child: Text('Error: ${snapshot.error}'),
        //               );
        //             } else {
        //               final categories = snapshot.data!;
        //               return ListView.builder(
        //                 shrinkWrap: true,
        //                 itemCount: categories.length,
        //                 scrollDirection: Axis.horizontal,
        //                 itemBuilder: (context, index) {
        //                   final category = categories[index];
        //                   var image = category!.image;
        //                   return GestureDetector(
        //                     onTap: () => Get.to(() => AdminSubCategoriesPage(
        //                           genre: category!.genre,
        //                         )),
        //                     child: Padding(
        //                       padding: const EdgeInsets.only(
        //                           right: Sizes.spaceBtwItems),
        //                       child: Column(
        //                         children: [
        //                           Container(
        //                             width: 56,
        //                             height: 56,
        //                             padding: const EdgeInsets.all(Sizes.sm),
        //                             decoration: BoxDecoration(
        //                               borderRadius: BorderRadius.circular(100),
        //                             ),
        //                             child: Center(
        //                               child:
        //                                 //  Image(image: AssetImage(Images.book)),
        //                               Image.network(
        //                                 'http://10.0.2.2:8000$image',
        //                                 errorBuilder: (context, error, stackTrace) {
        //                                   return Image.asset(Images.book);
        //                                 },
        //                               ),
        //                             ),
        //                           ),
        //                           const SizedBox(
        //                             height: Sizes.spaceBtwItems / 2,
        //                           ),
        //                           SizedBox(
        //                             child: Text(
        //                               category!.genre.length > 9
        //                                   ? '${category.genre.substring(0, 9)}...'
        //                                   : category.genre,
        //                               style: Theme.of(context)
        //                                   .textTheme
        //                                   .labelMedium!
        //                                   .apply(
        //                                     color: brown,
        //                                     fontWeightDelta: 2,
        //                                     fontSizeDelta: 0.4,
        //                                   ),
        //                               overflow: TextOverflow.ellipsis,
        //                             ),
        //                           ),
        //                         ],
        //                       ),
        //                     ),
        //                   );
        //                 },
        //               );
        //             }
        //           },
        //         ),
        //       )
        //     ],
        //   ),
        // ),
        );
  }
}
