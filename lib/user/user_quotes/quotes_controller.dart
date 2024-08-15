import 'package:booktaste/data/repositories/quote_repository.dart';
import 'package:booktaste/user/user_quotes/quote_model..dart';
import 'package:get/get.dart';

class AllQuotesController extends GetxController {
  var quotes = <Quote>[].obs;
  var allQuotesIsLoading = true.obs;

  @override
  void onInit() {
    fetchAllQuotes();
    super.onInit();
  }

  // void addQuote(String quote) {
  //   quotes.add(quote);
  // }

  // void deleteQuote(int index) {
  //   if (index >= 0 && index < quotes.length) {
  //     quotes.removeAt(index);
  //   }
  // }

  void fetchAllQuotes() async {
    try {
      allQuotesIsLoading.value = true;
      var allQuotes = await QuoteRepository().fetchAllQuotes();
      if (allQuotes != null) {
        print("All Quotes not null");
        quotes.value = allQuotes;
      }
    } catch (e) {
      print("Error fetching quotes in controller : $e");
    } finally {
      allQuotesIsLoading.value = false;
    }
  }

  Future<void> refreshQuotes() async {
    try {
      allQuotesIsLoading.value = true; // Optional: Show loading while fetching
      var allQuotes = await QuoteRepository().fetchAllQuotes();
      if (allQuotes != null) {
        quotes.value = allQuotes; // Update the quotes observable
      } else {
        print("Fetched quotes are null");
      }
    } catch (e) {
      print("Error refreshing quotes: $e");
      // Optionally show an error message to the user
    } finally {
      allQuotesIsLoading.value = false; // Hide loading
    }
  }
}
