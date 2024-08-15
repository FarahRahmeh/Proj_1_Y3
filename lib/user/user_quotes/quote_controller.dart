import 'dart:io';

import 'package:booktaste/data/repositories/quote_repository.dart';
import 'package:booktaste/user/navigation/user_navigation_menu.dart';
import 'package:booktaste/user/user_quotes/quotes_controller.dart';
import 'package:booktaste/user/user_quotes/quotes_page.dart';
import 'package:booktaste/utils/popups/loaders.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:convert';

import '../../admin/manage_books/add_book/cover_preview_page.dart';
import 'quote_model..dart';

class QuoteController extends GetxController {
  var quote = Quote().obs;
  var isLoading = true.obs;
  var isImageUploading = false.obs;
  var _quoteRepository = QuoteRepository();

  @override
  void onInit() {
    super.onInit();
  }

  void deleteImage() {
    quote.update((val) {
      val?.image = '';
    });
  }

  void pickImage() async {
    isImageUploading.value = true;
    try {
      // final pickedFile =
      //     await ImagePicker().pickImage(source: ImageSource.gallery);
      // if (pickedFile != null) {
      //   final File imageFile = File(pickedFile.path);
      //   // Here, you can implement image uploading if needed.
      //   quote.update((val) {
      //     val?.image = imageFile.path;
      //   });
      // } else {
      //   print('picking');
      // }
      final pickedFile =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        final File imageFile = File(pickedFile.path);
        if (await imageFile.exists()) {
          quote.update((val) {
            val?.image = imageFile.path;
          });
        } else {
          Loaders.errorSnackBar(
              title: 'Error', message: 'Image file not found');
        }
      } else {
        print('No image selected');
      }
    } catch (e) {
      Loaders.errorSnackBar(title: 'Error', message: e.toString());
      print("Image upload error: $e");
    } finally {
      isImageUploading.value = false;
      update();
    }
  }

  void previewImage() {
    if (quote.value.image!.isNotEmpty && quote.value.image != '') {
      Get.to(() => CoverPreviewPage(imagePath: quote.value.image!));
    }
  }

  Future<void> saveQuote() async {
    try {
      final response = await _quoteRepository.addQuote(
          author: quote.value.author.trim(),
          bookTitle: quote.value.bookTitle.trim(),
          fav: quote.value.fav.trim(),
          thoughts: quote.value.thoughts.trim(),
          sourceId: quote.value.sourceId.trim(),
          quoteText: quote.value.quote.trim(),
          page: quote.value.page.toString().trim(),
          image: quote.value.image);

      if (response.statusCode == 200) {
        print(response.body);

        Loaders.successSnackBar(
            title: 'Success',
            message: 'Quote added successfully',
            icon: Iconsax.archive_book_copy);

        final allQuotes = Get.put(AllQuotesController());
        allQuotes.fetchAllQuotes();
        // final navigationController = Get.find<UserNavigationController>();
        // navigationController.setSelectedIndex(3);
        Get.off(() => QuotesPage());
        // Get.back();
      } else {
        Loaders.errorSnackBar(
            title: 'Error',
            message: 'Failed to add quote: ${response.statusCode}');
        print('Error body ' + response.body + jsonEncode(quote));
      }
    } catch (error) {
      print(error);
      Loaders.errorSnackBar(
          title: 'Error Catched', message: 'An error occurred: $error');
    }
  }

  Future<void> removeQuote(String id) async {
    try {
      final response = await _quoteRepository.deleteQuote(id);
      if (response.statusCode == 200) {
        Loaders.successSnackBar(
            title: 'Success',
            message: ' deleted successfully!',
            icon: Iconsax.archive_book_copy);

        final allQuotes = Get.put(AllQuotesController());
        allQuotes.fetchAllQuotes();
      } else {
        Loaders.errorSnackBar(
            title: 'Error',
            message: 'Failed to delete quote: ${response.statusCode}');
        print('Error delete quote body ' + response.body);
      }
    } catch (error) {
      Loaders.errorSnackBar(
          title: 'Error Catched on delete quote',
          message: 'An error occurred: $error');
    } finally {
      update();
    }
  }

  Future<void> updateQuote(int quoteId) async {
    // isLoading.value = true;
    try {
      final response = await _quoteRepository.updateQuote(
          quoteId: quoteId,
          author: quote.value.author.trim(),
          bookTitle: quote.value.bookTitle.trim(),
          fav: quote.value.fav.trim(),
          thoughts: quote.value.thoughts.trim(),
          sourceId: quote.value.sourceId.trim(),
          quoteText: quote.value.quote.trim(),
          page: quote.value.page.toString().trim(),
          image: quote.value.image);
      if (response.statusCode == 200) {
        Loaders.successSnackBar(title: 'success');

        final allQuotes = Get.put(AllQuotesController());
        allQuotes.fetchAllQuotes();
        Get.off(() => UserNavigationMenu());
      } else {
        Loaders.errorSnackBar(
            title: 'Error',
            message: 'Failed to update quote: ${response.statusCode}');
        print('Error update quote body ' + response.body);
      }
    } catch (e) {
      Loaders.errorSnackBar(
          title: 'Error Catched on update quote',
          message: 'An error occurred: $e');
    } finally {
      print('update finally');
      //.value = false;
    }
  }
}
