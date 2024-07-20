import 'dart:typed_data';

import 'package:booktaste/common/widgets/custom_shapes/Containers/rounded_container.dart';
import 'package:booktaste/common/widgets/images/rounded_image.dart';
import 'package:booktaste/common/widgets/shimmers/category_shimmer.dart';
import 'package:booktaste/models/book.dart';
import 'package:booktaste/models/all_categories_model.dart';
import 'package:booktaste/user/user_sub_category/sub_categories_page.dart';
import 'package:booktaste/utils/constans/api_constans.dart';
import 'package:booktaste/utils/constans/colors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../../../data/repositories/categories_repository.dart';
import '../../../utils/constans/sizes.dart';
import '../../widgets/image_with_text/vertical_image_text.dart';
import '../../../controllers/category/all_categories_controller.dart';
import '../../../utils/constans/images.dart';
import '../../../admin/home/admin_sub_category/sub_categories_page.dart';
import '../../widgets/shimmers/shimmer.dart';

class HomeCategories extends StatelessWidget {
  HomeCategories({super.key});

  @override
  Widget build(BuildContext context) {
    final allCategoriesController =
        Get.put(AllCategoriesController()); //, permanent: true

    return Obx(() {
      if (allCategoriesController.isLoading.value == true) {
        return CategoryShimmer(
          itemCount: allCategoriesController.allCategoriesList.length,
        );
      } else {
        return SizedBox(
          height: 80,
          child: FutureBuilder<List<AllCategories?>?>(
            future: AllCategoriesRepository.fechAllCategories(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CategoryShimmer(
                  itemCount: allCategoriesController.allCategoriesList.length,
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('Error: ${snapshot.error}'),
                );
              } else if (!snapshot.hasData || snapshot.data == null) {
                return Center(
                  child: Text('No categories available.'),
                );
              } else {
                final categories = snapshot.data;

                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: categories!.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    //!---------- genre / shelf / category obj-------
                    final category = categories[index];
                    if (category == null) {
                      return SizedBox.shrink(); // Skip null categories
                    }
                    var image = category.image;
                    return GestureDetector(
                      onTap: () => Get.to(() => SubCategoriesPage(
                            genre: category.genre,
                            category: category,
                          )),
                      child: Padding(
                        padding:
                            const EdgeInsets.only(right: Sizes.spaceBtwItems),
                        child: Column(
                          children: [
                            Container(
                              width: 56,
                              height: 56,
                              padding: const EdgeInsets.all(Sizes.sm),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                              ),
                              //! image
                              child: Center(
                                child: image == '/'
                                    ? Center(
                                        child: Image(
                                            image: AssetImage(
                                                Images.defaultBookCover)))
                                    : CachedNetworkImage(
                                        fit: BoxFit.cover,
                                        imageUrl: '$baseImageUrl$image',
                                        errorWidget: (context, url, error) =>
                                            SizedBox(
                                          width: 20,
                                          height: 20,
                                          child: Center(
                                              child:
                                                  Icon(Iconsax.warning_2_copy)),
                                        ),
                                        progressIndicatorBuilder:
                                            (context, url, progress) => Center(
                                          child: ShimmerEffect(
                                            height: 50,
                                            width: 50,
                                          ),
                                        ),
                                      ),

                                //Image(image: AssetImage(Images.book)),
                                // If you have network images:
                                //child: Image.network(
                                //'$baseImageUrl$image',
                                //   errorBuilder: (context, error, stackTrace) {
                                //     return Image.asset(Images.book);
                                //   },
                              ),
                            ),
                            const SizedBox(
                              height: Sizes.spaceBtwItems / 2,
                            ),
                            SizedBox(
                              child: Text(
                                category.genre.length > 9
                                    ? '${category.genre.substring(0, 9)}...'
                                    : category.genre,
                                style: Theme.of(context)
                                    .textTheme
                                    .labelMedium!
                                    .apply(
                                      color: brown,
                                      fontWeightDelta: 2,
                                      fontSizeDelta: 0.4,
                                    ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }
            },
          ),
        );
      }
    });
  }
}

// CachedNetworkImage(
//                     imageUrl: imageUrl,
//                     fit: fit,
//                     progressIndicatorBuilder:
//                         (context, url, downloadProgress) =>
//                             const ShimmerEffect(width: 55, height: 55),
//                     errorWidget: (context, url, error) =>
//                         Icon(Iconsax.warning_2_copy),
//                   )