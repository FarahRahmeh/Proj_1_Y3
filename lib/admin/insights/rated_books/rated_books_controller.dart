// import 'dart:convert';
import 'package:booktaste/models/rate_book.dart';
import 'package:booktaste/utils/constans/api_constans.dart';
import 'package:booktaste/utils/popups/loaders.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:get_storage/get_storage.dart';

import '../../../utils/constans/colors.dart';

class RatedBooksController extends GetxController {
  var bookList = <RateBook>[].obs;
  var isBooksLoading = false.obs;
  var selectedSortOrder = 'desc'.obs;
  var bookListAsc = <RateBook>[].obs;
  var bookListDesc = <RateBook>[].obs;

  @override
  void onInit() {
    fetchRatedBooks('asc');
    fetchRatedBooks('desc');
    super.onInit();
  }

  void updateSortOrder(String order) {
    selectedSortOrder.value = order;
    fetchRatedBooks(order);
  }

  List<RateBook> getTopThreeBooks() {
    return bookListDesc.take(3).toList();
  }

  List<RateBook> getLeastThreeBooks() {
    return bookListAsc.take(3).toList();
  }

  Future<void> fetchRatedBooks(String byOrder) async {
    try {
      isBooksLoading.value = true;
      final response = await http.get(
        Uri.parse('$baseUrl/byRate/$byOrder'),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${GetStorage().read('TOKEN')}',
        },
      );
      if (response.statusCode == 200) {
        var books = rateBookFromJson(response.body);
        bookList.assignAll(books);
        if (byOrder == 'asc') {
          bookListAsc.assignAll(books);
        } else {
          bookListDesc.assignAll(books);
        }
      } else {
        Loaders.errorSnackBar(title: 'Oops', message: 'Failed to fetch books');
      }
    } catch (e) {
      Loaders.errorSnackBar(title: 'On Snap', message: e.toString());
    } finally {
      isBooksLoading.value = false;
    }
  }

  List<BarChartGroupData> getBarChartData(List<RateBook> books) {
    return books.asMap().entries.map((entry) {
      int index = entry.key;
      RateBook book = entry.value;
      return BarChartGroupData(
        x: index,
        barRods: [
          BarChartRodData(
            width: 10,
            y: book.stars!.toDouble(),
            colors: [
              lightBrown,
              brown.withOpacity(0.8),
            ],
          ),
        ],
      );
    }).toList();
  }
}
