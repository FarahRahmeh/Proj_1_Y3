import 'package:booktaste/admin/insights/single_genre_stat/single_genre_stat_view.dart';
import 'package:booktaste/common/widgets/appbar/appbar.dart';
import 'package:booktaste/common/widgets/images/rounded_image.dart';
import 'package:booktaste/common/widgets/layouts/grid_layout.dart';
import 'package:booktaste/common/widgets/products/product_card/product_card_vertical.dart';
import 'package:booktaste/common/widgets/texts/section_heading.dart';
import 'package:booktaste/controllers/category/all_categories_controller.dart';
import 'package:booktaste/data/services/role.manager.dart';
import 'package:booktaste/models/all_categories_model.dart';
import 'package:booktaste/models/cafe_shelf_model.dart';
import 'package:booktaste/utils/constans/images.dart';
import 'package:booktaste/utils/constans/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';


class SubCategoriesPage extends StatelessWidget {
  const SubCategoriesPage({
    super.key,
    required this.genre,
    this.category,
    this.shelf,
  });
  final String genre;
  final CafeShelf? shelf;
  final AllCategories? category;

  @override
  Widget build(BuildContext context) {
    String genree = genre.toUpperCase();
    final genreBooksCtrl = Get.put(AllCategoriesController());
    genreBooksCtrl.fetchCategoryBooks(
        shelf == null ? category!.id.toString() : shelf!.id.toString());

    return Scaffold(
      appBar: MyAppBar(
        title: Text(genree),
        showBackArrow: true,
        actions: [
          FutureBuilder<bool>(
              future: isUser(),
              builder: (builder, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  final user = snapshot.data;
                  return user == false
                      ? IconButton(
                          onPressed: () {
                            Get.to(
                              () => ShelfStatPage(
                                  id: shelf != null
                                      ? shelf!.id.toString()
                                      : category!.id.toString()),
                            );
                          },
                          icon: Icon(Iconsax.chart_2_copy),
                        )
                      : SizedBox();
                }
              }),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(Sizes.defaultSpace),
          child: Column(
            children: [
              ///Banner
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RoundedImage(
                    // imageUrl: Images.promoBanner,
                    isNetworkImage: true,
                    imageUrl: category != null
                        ? category!.image
                        : '/' + '${shelf!.image}',
                    shHeight: 100,
                    shWidth: 100,
                    height: 100,
                    applyImageRadius: false,
                  ),
                ],
              ),
              SizedBox(
                height: Sizes.spaceBtwSections,
              ),

              ///Sub-Categries
              Column(
                children: [
                  SectionHeading(
                    title: '$genre books',
                    onPressed: () {},
                    showActionButton: false,
                  ),
                  SizedBox(
                    height: Sizes.spaceBtwItems / 2,
                  ),
                  Obx(() {
                    if (genreBooksCtrl.isCaBooksLoading.value) {
                      return Center(
                          child: Image.asset(
                        width: 90,
                        Images.coffeeLoading,
                      ));
                    } else if (genreBooksCtrl.categoryBooks.isEmpty) {
                      return Center(
                        child: Text('data empty'),
                      );
                    } else {
                      return MyGridLayout(
                        itemCount: genreBooksCtrl.categoryBooks.length,
                        itemBuilder: (_, index) => ProductCardVertical(
                            allbooks: genreBooksCtrl.categoryBooks[index]),
                        // ListTile(
                        //   title: Text(genreBooksCtrl.categoryBooks[index].name),
                        // ),
                      );
                    }
                  }),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
