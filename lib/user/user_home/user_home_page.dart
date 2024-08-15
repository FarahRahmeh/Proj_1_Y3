import 'package:booktaste/common/features/books/all_books_with_filter_page.dart';
import 'package:booktaste/common/features/challenges/challenge_controller.dart';
import 'package:booktaste/common/features/challenges/challenge_model.dart';
import 'package:booktaste/common/widgets/custom_shapes/Containers/primary_header_container.dart';
import 'package:booktaste/common/widgets/custom_shapes/Containers/rounded_container.dart';
import 'package:booktaste/common/widgets/layouts/grid_layout.dart';
import 'package:booktaste/common/widgets/products/product_card/product_card_vertical.dart';
import 'package:booktaste/models/book.dart';
import 'package:booktaste/user/user_all_books/all_books_controller.dart';
import 'package:booktaste/utils/constans/colors.dart';
import 'package:booktaste/utils/constans/images.dart';
import 'package:booktaste/utils/constans/sizes.dart';
import 'package:booktaste/utils/constans/texts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../common/features/categories/home_categories.dart';
import '../../common/features/challenges/challenges_view.dart';
import '../../common/widgets/custom_shapes/Containers/search_container.dart';
import '../../common/widgets/texts/section_heading.dart';
import 'user_home_widgets/user_home_appbar.dart';
import '../../common/features/cafes/cafes_home_slider.dart';

class UserHomePage extends StatelessWidget {
  // final allcategoriescontroller = Get.put(AllCategoriesController());
  UserHomePage({super.key});

  final allbookscontroller = Get.put(AllBooksController());
  final challengeController = Get.put(ChallengeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      ///!Heading
      child: Column(
        children: [
          PrimaryHeaderContainer(
            height: 390,
            child: Column(
              children: [
                ///!Appbar
                UserHomePageAppbar(),

                const SizedBox(
                  height: Sizes.spaceBtwSections,
                ),

                ///!Searchbar
                ///todo here should be a Row to add the "ADD Book" button
                SearchContainer(
                  text: Texts.homeSearchTitle,
                ),
                const SizedBox(
                  height: Sizes.spaceBtwSections,
                ),

                ///! ---Categories Section--
                Padding(
                  padding: EdgeInsets.only(left: Sizes.defaultSpace),
                  child: Column(
                    children: [
                      ///---Heading
                      SectionHeading(
                        title: 'Categories', //~------------ same color
                        showActionButton: false,
                      ),
                      const SizedBox(
                        height: Sizes.spaceBtwItems / 2,
                      ),

                      ///!---Categories List
                      HomeCategories(), //--->inside here //~------------ same color
                    ],
                  ),
                ),
              ],
            ),
          ),

          ///! Body
          const Padding(
            padding: EdgeInsets.only(left: Sizes.defaultSpace),
            child: SectionHeading(
              title: 'Cafés',
              showActionButton: false,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(Sizes.md), //Sizes.defultSpace
            child: Column(
              children: [
                ///! Cafes Slider
                CafesSlider(
                    // banners: [
                    //   Images.cover2,
                    //   // Images.success,
                    //   // Images.promoBanner,
                    //   // Images.onboarding_1,
                    //   // Images.onboarding_1,
                    //   // Images.onboarding_1,
                    //   // Images.onboarding_1,
                    // ],
                    ),

                const SizedBox(height: Sizes.sm),

                //! Heading Popular Books
                SectionHeading(
                  title: 'Popular Books',
                  onPressed: () {
                    Get.to(() => AllBooksWithFilter());
                  },
                ),
                const SizedBox(
                  height: Sizes.spaceBtwItems,
                ),

                ///!All books grid layout
                // Obx(() {
                //   if (allbookscontroller.isLoading.value) {
                //     // return ProductCardVerticalShimmer(
                //     //     itemCount: allbookscontroller.booksList.length);
                //     return Center(
                //         child: Image.asset(
                //       width: 90,
                //       Images.coffeeLoading,
                //     ));
                //   } else {
                //     return MyGridLayout(
                //       itemCount: allbookscontroller.booksList.length,
                //       itemBuilder: (_, index) => ProductCardVertical(
                //         bookk: allbookscontroller.booksList[index],
                //       ),
                //     );
                //   }
                // }),
                FutureBuilder<List<Book?>?>(
                  future: allbookscontroller.fetchAllBooks(), // Call the method
                  builder: (BuildContext context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return Center(child: Text('No popular books available'));
                    } else {
                      return MyGridLayout(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (_, index) => ProductCardVertical(
                          bookk: snapshot.data![index],
                        ),
                      );
                    }
                  },
                ),
                const SizedBox(height: Sizes.sm),
                //! Heading Popular Books
                SectionHeading(
                  title: 'Recommended For You!',
                  onPressed: () {
                    //Get.to(() => AllBooksWithFilter());
                  },
                ),
                const SizedBox(
                  height: Sizes.spaceBtwItems,
                ),

                ///!Recommended books grid layout
                // Obx(() {
                //   if (allbookscontroller.recommendIsLoading.value) {
                //     return Center(
                //         child: Image.asset(
                //       width: 90,
                //       Images.coffeeLoading,
                //     ));
                //   } else if (allbookscontroller.recommendation.isEmpty) {
                //     return Center(
                //       child: Text('data empty'),
                //     );
                //   } else {
                //     return MyGridLayout(
                //       itemCount: allbookscontroller.recommendation.length,
                //       itemBuilder: (_, index) => ProductCardVertical(
                //         bookk: allbookscontroller.recommendation[index],
                //       ),
                //     );
                //   }
                // }),
                FutureBuilder<List<Book?>?>(
                  future: allbookscontroller.fetchRecommended(),
                  builder: (BuildContext context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return Center(
                          child: Text('No recommendations available'));
                    } else {
                      return MyGridLayout(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (_, index) => ProductCardVertical(
                          bookk: snapshot.data![index],
                        ),
                      );
                    }
                  },
                ),
                const SizedBox(height: Sizes.sm),
                //! Challenge Section
                SectionHeading(
                  title: 'Challenges !',
                  showActionButton: false,
                ),
                FutureBuilder<List<Challenge?>>(
                  future: challengeController.fetchChallenges(),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<Challenge?>> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return Center(child: Text('No challenges available'));
                    } else {
                      // Filter to get the open challenge
                      final openChallenge = snapshot.data!.firstWhereOrNull(
                          (challenge) => challenge?.isOpen == 1);

                      if (openChallenge == null) {
                        return Center(
                            child: Text('No open challenge at the moment'));
                      } else {
                        return RoundedContainer(
                          margin: EdgeInsets.symmetric(vertical: Sizes.sm),
                          backgroundColor: pinkish,
                          child: ListTile(
                            title: Text(
                              openChallenge.name ?? 'Unknown Challenge',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(color: Colors.white),
                            ),
                            subtitle: Text(
                              openChallenge.description ??
                                  'No description available',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(color: Colors.white70),
                            ),
                            leading: Icon(Icons.campaign, color: Colors.white),
                            trailing: Text('Go',
                                style: TextStyle(color: Colors.white)),
                            onTap: () {
                              Get.to(() => ChallengeDetailPage(
                                  challenge: openChallenge));
                            },
                          ),
                        );
                      }
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
