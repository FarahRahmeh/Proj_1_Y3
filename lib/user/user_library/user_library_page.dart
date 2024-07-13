import 'package:booktaste/common/widgets/appbar/appbar.dart';
import 'package:booktaste/common/widgets/appbar/tapbar.dart';
import 'package:booktaste/common/widgets/custom_shapes/Containers/search_container.dart';
import 'package:booktaste/common/widgets/layouts/grid_layout.dart';
import 'package:booktaste/common/widgets/notification/notification_counter_icon.dart';
import 'package:booktaste/common/widgets/texts/section_heading.dart';
import 'package:booktaste/controllers/category/all_categories_controller.dart';
import 'package:booktaste/user/user_all_brands/all_brands_page.dart';
import 'package:booktaste/user/user_library/user_library_widgets/category_tab.dart';
import 'package:booktaste/utils/constans/colors.dart';
import 'package:booktaste/utils/constans/sizes.dart';
import 'package:booktaste/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../common/widgets/category/x_card.dart';

class UserLibrary extends StatelessWidget {
  const UserLibrary({super.key});

  @override
  Widget build(BuildContext context) {
    final categoriesCtrl = Get.find<AllCategoriesController>();

    return DefaultTabController(
      length: categoriesCtrl.allCategoriesList.length, //= number of tabs
      child: Scaffold(
        //!Appbar
        appBar: MyAppBar(
          title: Text(
            'Library',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          actions: [
            NotificationCounterIcon(
              onPressed: () {},
              iconColor: lightBrown,
            ),
          ],
        ),
        //!Body
        body: NestedScrollView(
          headerSliverBuilder: (_, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                pinned: true,
                floating: true,
                backgroundColor: HelperFunctions.isDarkMode(context)
                    ? MyColors.black
                    : MyColors.white,
                expandedHeight: 440,
                automaticallyImplyLeading: false,
                flexibleSpace: FlexibleSpaceBar(
                  background: Padding(
                    padding: const EdgeInsets.all(Sizes.defaultSpace),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //!    --Search bar
                        SizedBox(height: Sizes.spaceBtwItems),
                        SearchContainer(
                          text: 'Search in Library',
                          showBorder: true,
                          showBackground: false,
                          padding: EdgeInsets.zero,
                        ),
                        SizedBox(height: Sizes.spaceBtwSections),

                        //! ---Featured brands
                        SectionHeading(
                          title: 'Featured ~~~',
                          onPressed: () => Get.to(() => AllBrandsPage()),
                        ),
                        const SizedBox(height: Sizes.spaceBtwItems / 1.5),

                        MyGridLayout(
                            mainAxisExtent: 80,
                            itemCount: 4,
                            itemBuilder: (_, index) {
                              return XCard();
                            }),
                      ],
                    ),
                  ),
                ),

                ///! Tabs
                bottom: MyTapBar(
                  tabs: categoriesCtrl.allCategoriesList
                      .map((category) => Tab(
                            child: Text(category.genre),
                          ))
                      .toList(),
                ),
              ),
            ];
          },
          body: TabBarView(
            children: categoriesCtrl.allCategoriesList
                .map((category) => CategoryTab(category: category.genre))
                .toList(),
          ),
        ),
      ),
    );
  }
}
