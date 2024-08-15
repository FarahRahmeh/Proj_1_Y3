import 'package:booktaste/utils/constans/colors.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:get/get.dart';

import '../../../data/repositories/book_repository.dart';
import '../../../models/popular_book_model.dart';

class PopularBooksController extends GetxController {
  var isBooksLoading = false.obs;
  var bookList = <PopularBook>[].obs;
  var selectedSortOrder = 'desc'.obs;
  var bookListAsc = <PopularBook>[].obs;
  var bookListDesc = <PopularBook>[].obs;

  final BookRepository bookRepository = Get.put(BookRepository());

  @override
  void onInit() {
    fetchPopularBooks('asc');
    fetchPopularBooks('desc');
    fetchPopularBooks(selectedSortOrder.value);
    super.onInit();
  }

  Future<void> fetchPopularBooks(String sortOrder) async {
    try {
      isBooksLoading(true);
      var response = await bookRepository.fetchPopularBooks(sortOrder);

      if (response.statusCode == 200) {
        var books = popularBookFromJson(response.body);
        bookList.assignAll(books);
        if (sortOrder == 'asc') {
          bookListAsc.assignAll(books);
        } else {
          bookListDesc.assignAll(books);
        }
      } else {
        Get.snackbar('Error', 'Failed to fetch books');
        print('Failed to fetch books');
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred while fetching books');
      print('Error occurred: $e');
    } finally {
      isBooksLoading(false);
    }
  }

  void updateSortOrder(String order) {
    selectedSortOrder.value = order;
    fetchPopularBooks(order);
  }

  List<PopularBook> getTopThreeBooks() {
    return bookList.take(3).toList();
  }

  List<PopularBook> getLeastThreeBooks() {
    return bookList.reversed.take(3).toList();
  }

  //   List<PopularBook> getTopThreeBooks() {
  //   return bookList
  //       .where((book) => book.readPercent != null)
  //       .toList()
  //       ..sort((a, b) => (b.readPercent ?? 0).compareTo(a.readPercent ?? 0))
  //       .take(3)
  //       .toList();
  // }

  // List<PopularBook> getLeastThreeBooks() {
  //   return bookList
  //       .where((book) => book.readPercent != null)
  //       .toList()
  //       ..sort((a, b) => (a.readPercent ?? 0).compareTo(b.readPercent ?? 0))
  //       .take(3)
  //       .toList();
  // }

  List<BarChartGroupData> getBarChartData(List<PopularBook> books) {
    return books.asMap().entries.map((entry) {
      int index = entry.key;
      PopularBook book = entry.value;
      return BarChartGroupData(
        x: index,
        barRods: [
          BarChartRodData(
            width: 10,
            y: book.readPercent?.toDouble() ?? 0.0,
            colors: [
              lightBrown,
              pinkish.withOpacity(0.7),
            ],
          ),
        ],
      );
    }).toList();
  }

  // List<BarChartGroupData> getBarChartData() {
  //   return bookList.asMap().entries.map((entry) {
  //     int index = entry.key;
  //     PopularBook book = entry.value;

  //     return BarChartGroupData(
  //       x: index,
  //       barRods: [
  //         BarChartRodData(
  //           toY: book.readPercent?.toDouble() ?? 0.0,
  //           color: lightBrown,
  //           //gradient: [Colors.blueAccent],
  //         ),
  //       ],
  //     );
  //   }).toList();
  // }
}
