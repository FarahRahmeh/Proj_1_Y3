import 'package:booktaste/admin/insights/genres_statistics/genres_stats_view.dart';
import 'package:booktaste/admin/insights/popular_books/asc_popular_books_view.dart';
import 'package:booktaste/admin/insights/popular_books/desc_popular_books_view.dart';
import 'package:booktaste/admin/insights/popular_books/popular_books_page.dart';
import 'package:booktaste/admin/insights/rated_books/asc_rated_books_view.dart';
import 'package:booktaste/admin/insights/rated_books/desc_rated_books_view.dart';
import 'package:booktaste/admin/insights/rated_books/rated_books_controller.dart';
import 'package:booktaste/admin/insights/rated_books/rated_books_view.dart';
import 'package:booktaste/common/widgets/appbar/appbar.dart';
import 'package:booktaste/common/widgets/layouts/grid_layout.dart';
import 'package:booktaste/common/widgets/products/product_card/product_tile.dart';
import 'package:booktaste/common/widgets/texts/section_heading.dart';
import 'package:booktaste/models/popular_book_model.dart';
import 'package:booktaste/models/rate_book.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import 'popular_books/popular_books_controller.dart';

class InsightsPage extends StatelessWidget {
  InsightsPage({super.key});
  //final allCategoriesController = Get.find<AllCategoriesController>();
  final popularBooksController = Get.put(PopularBooksController());
  final ratedBooksCtrl = Get.put(RatedBooksController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: Text('Insights'),
        actions: [
          IconButton(
            // onPressed: () {},
            onPressed: () => Get.to(() => PopularBooksPage()),
            icon: Icon(Iconsax.chart_1_copy),
          ),
          IconButton(
            onPressed: () => Get.to(() => RatedBooksPage()),
            icon: Icon(Iconsax.magic_star_copy),
          ),
          IconButton(
            onPressed: () => Get.to(() => GenresStatsPage()),
            icon: Icon(Iconsax.chart_square_copy),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              children: [
                Obx(() {
                  if (popularBooksController.isBooksLoading.value) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (popularBooksController.bookListAsc.isEmpty &&
                      popularBooksController.bookListDesc.isEmpty) {
                    return Center(child: Text('No books available'));
                  } else {
                    print(popularBooksController.bookList);
                    List<PopularBook> topThreeBooks =
                        popularBooksController.getTopThreeBooks();
                    List<PopularBook> leastThreeBooks =
                        popularBooksController.getLeastThreeBooks();
                    return SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              children: [
                                SectionHeading(
                                  title: 'Top 3 Read Books',
                                  onPressed: () =>
                                      Get.to(() => PopularDescBooksPage()),
                                ),
                                MyGridLayout(
                                  mainAxisSpacing: 2,
                                  mainAxisExtent: 100,
                                  crossAxisCount: 1,
                                  itemCount: topThreeBooks.length,
                                  itemBuilder: (_, index) {
                                    var book = topThreeBooks[index];
                                    return ProductTile(popBook: book);
                                  },
                                )
                              ],
                            ),
                            SizedBox(height: 16.0),
                            Column(
                              children: [
                                SectionHeading(
                                  title: 'Least 3 Read Books',
                                  onPressed: () =>
                                      Get.to(() => PopularAscBooksPage()),
                                ),
                                MyGridLayout(
                                  mainAxisExtent: 100,
                                  crossAxisCount: 1,
                                  itemCount: leastThreeBooks.length,
                                  itemBuilder: (_, index) {
                                    var book = leastThreeBooks[index];

                                    return ProductTile(popBook: book);
                                  },
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                }),
              ],
            ),

            //! Rated
            Column(
              children: [
                Obx(() {
                  if (ratedBooksCtrl.isBooksLoading.value) {
                    return Center(child: CircularProgressIndicator());
                  }

                  if (ratedBooksCtrl.bookList.isEmpty) {
                    return Center(child: Text('No books available'));
                  }

                  // Fetch top 3 and least 3 books
                  List<RateBook> topThreeBooks =
                      ratedBooksCtrl.getTopThreeBooks();
                  List<RateBook> leastThreeBooks =
                      ratedBooksCtrl.getLeastThreeBooks();

                  return SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            children: [
                              SectionHeading(
                                title: 'Top 3 Rated Books',
                                onPressed: () =>
                                    Get.to(() => RatedDescBooksPage()),
                              ),
                              MyGridLayout(
                                mainAxisSpacing: 2,
                                mainAxisExtent: 100,
                                crossAxisCount: 1,
                                itemCount: topThreeBooks.length,
                                itemBuilder: (_, index) {
                                  var book = topThreeBooks[index];
                                  return ProductTile(rateBook: book);
                                },
                              )
                            ],
                          ),
                          SizedBox(height: 16.0),
                          Column(
                            children: [
                              SectionHeading(
                                title: 'Least 3 Rated Books',
                                onPressed: () =>
                                    Get.to(() => RatedAscBooksPage()),
                              ),
                              MyGridLayout(
                                mainAxisExtent: 100,
                                crossAxisCount: 1,
                                itemCount: leastThreeBooks.length,
                                itemBuilder: (_, index) {
                                  var book = leastThreeBooks[index];

                                  return ProductTile(rateBook: book);
                                },
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
