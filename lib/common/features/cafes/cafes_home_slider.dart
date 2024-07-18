import 'package:booktaste/controllers/cafe/cafes_controller.dart';
import 'package:booktaste/data/repositories/cafes_repository.dart';
import 'package:booktaste/models/cafe_model.dart';
import 'package:booktaste/common/features/cafes/cafes_page.dart';
import 'package:booktaste/utils/constans/colors.dart';
import 'package:booktaste/utils/constans/images.dart';
import 'package:booktaste/utils/constans/sizes.dart';
import 'package:booktaste/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widgets/images/rounded_image.dart';

class CafesSlider extends StatelessWidget {
  const CafesSlider({
    super.key,
    // required this.banners,
  });

  // final List<String> banners;

  @override
  Widget build(BuildContext context) {
    final allCafesController = Get.put(CafesController());
    final dark = HelperFunctions.isDarkMode(context);

    return Column(
      children: [
        Obx(() {
          if (allCafesController.isLoading.value) {
            return Center(
              child: Image.asset(
                width: 90,
                Images.coffeeLoading,
              ),
            );
          } else {
            return FutureBuilder<List<Cafe?>?>(
              future: CafesRepository.fechAllCafes(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: Image.asset(
                      width: 90,
                      Images.coffeeLoading,
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      'Error: ${snapshot.error}',
                    ),
                  );
                } else {
                  return SizedBox(
                    height: 200,
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: allCafesController.cafesList.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        final cafe = allCafesController.cafesList[index];
                        return GestureDetector(
                          onTap: () {
                            Get.to(
                              () => CafePage(
                                cafe: cafe,
                                cafeId: cafe.id.toString(),
                              ),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(right: Sizes.sm),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 150,
                                  width: 200,
                                  child: RoundedImage(
                                    imageUrl: Images.book,
                                    fit: BoxFit.cover,
                                    title: cafe.name,
                                  ),
                                ),
                                SizedBox(
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: Sizes.xs, left: Sizes.xs),
                                    child: Text(
                                      cafe.name,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge!
                                          .apply(
                                            color: dark ? lightBrown : brown,
                                          ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  );
                }
              },
            );
          }
        }),
      ],
    );
  }
}
