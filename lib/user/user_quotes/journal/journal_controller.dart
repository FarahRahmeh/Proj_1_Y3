import 'dart:convert';

import 'package:booktaste/data/repositories/journal_repository.dart';
import 'package:booktaste/user/navigation/user_navigation_menu.dart';
import 'package:booktaste/user/user_quotes/journal/journal_model.dart';
import 'package:booktaste/user/user_quotes/quote_model..dart';
import 'package:booktaste/user/user_quotes/quotes_controller.dart';
import 'package:booktaste/utils/constans/api_constans.dart';
import 'package:booktaste/utils/constans/colors.dart';
import 'package:booktaste/utils/popups/loaders.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:path/path.dart' as p;
import 'package:http/http.dart' as http;

class JournalController extends GetxController {
  var journalLoading = true.obs;
  var journalCards = <Journal>[].obs;
  var journalQuotes = <Quote>[].obs;
  var journalQLoading = true.obs;
  var journal = Journal().obs;
  var isRemoveMode = false.obs;

  var selectedQuotesToRemove = <int>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchAllJournals();
  }

  void toggleRemoveMode() {
    isRemoveMode.value = !isRemoveMode.value;
    if (!isRemoveMode.value) {
      selectedQuotesToRemove.clear();
    }
  }

  void toggleQuoteSelection(int quoteId, bool isSelected) {
    if (isSelected) {
      selectedQuotesToRemove.add(quoteId);
    } else {
      selectedQuotesToRemove.remove(quoteId);
    }
  }

  void confirmRemove(int journalId) {
    if (selectedQuotesToRemove.length == 0) {
      Loaders.warningSnackBar(
          title: 'Seriously!',
          message: 'you did not select any quotes to remove');
    } else {
      Get.dialog(
        AlertDialog(
          title: Text('Confirm Remove'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                          text:
                              'Are you sure you want to remove the selected quotes from this journal?'),
                      TextSpan(
                        text:
                            '\n\nYou still can find them in the gernal journal.',
                        style: TextStyle(
                          color: MyColors.darkGrey,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     Image.asset(
                //       Images.quoteLetters,
                //       width: 130,
                //       height: 130,
                //     ),
                //   ],
                // )
              ],
            ),
          ),
          actions: [
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Get.back();
              },
            ),
            TextButton(
              child: Text('Remove'),
              onPressed: () {
                removeSelectedQuotesFromJournal(
                    journalId, selectedQuotesToRemove);
                Get.back();
              },
            ),
          ],
        ),
      );
    }
  }
  // void addJournalCard(Journal journal) {
  //   journalCards.add(journal);
  //   //JournalRepositroy().saveJournal(journal);
  // }

  // void deleteJournalCard(int index) {
  //   if (index >= 0 && index < journalCards.length) {
  //     journalCards.removeAt(index);
  //   }
  // }

  Future<void> saveJournal() async {
    try {
      final response = await JournalRepository().addJournal(
          journalName: journal.value.name,
          bio: journal.value.bio,
          image: journal.value.imageName.toString(),
          year: journal.value.year.toString());

      if (response.statusCode == 200) {
        print(response.body);
        Loaders.successSnackBar(
            title: 'Success',
            message: 'Journal added successfully',
            icon: Iconsax.archive_book_copy);
        final ctrl = Get.put(JournalController());
        ctrl.fetchAllJournals();
      } else {
        Loaders.errorSnackBar(
            title: 'Error',
            message: 'Failed to add journal: ${response.statusCode}');
        print('Error body ' + response.body + jsonEncode(journal));
      }
    } catch (error) {
      print(error);
      Loaders.errorSnackBar(
          title: 'Error Catched', message: 'An error occurred: $error');
    }
  }

  Future<void> journalUpdate() async {
    try {
      final response = await JournalRepository().updateJournal(
          id: journal.value.id.toString(),
          journalName: journal.value.name,
          bio: journal.value.bio,
          image: journal.value.imageName.toString(),
          year: journal.value.year.toString());

      if (response.statusCode == 200) {
        print(response.body);
        Loaders.successSnackBar(
            title: 'Success',
            message: 'Journal updated successfully',
            icon: Iconsax.archive_book_copy);
        final ctrl = Get.put(JournalController());
        ctrl.fetchAllJournals();
        Get.to(() => UserNavigationMenu());
      } else {
        Loaders.errorSnackBar(
            title: 'Error',
            message: 'Failed to update journal: ${response.statusCode}');
        print('Error body ' + response.body + jsonEncode(journal));
      }
    } catch (error) {
      print(error);
      Loaders.errorSnackBar(
          title: 'Error Catched', message: 'An error occurred: $error');
    }
  }

  void fetchAllJournals() async {
    try {
      journalLoading.value = true;
      var allJournals = await JournalRepository().fetchAllJournals();
      if (allJournals != null) {
        print("All Journals not null");
        journalCards.value = allJournals;
      }
    } catch (e) {
      print("Error fetching Journals in controller : $e");
    } finally {
      journalLoading.value = false;
    }
  }

  void fetchJournalQuotes(int journalId) async {
    try {
      journalQLoading.value = true;
      var journalQuotesFetched =
          await JournalRepository().fetchJournalQuotes(journalId);
      if (journalQuotesFetched != null) {
        print("All Journals not null");
        journalQuotes.value = journalQuotesFetched;
      }
    } catch (e) {
      print('Error fetching quotes: $e');
    } finally {
      journalQLoading.value = false;
    }
  }

  Future<void> JournalDelete(String id, bool deleteOnlyJournal) async {
    try {
      final response =
          await JournalRepository().deleteJournal(id, deleteOnlyJournal);
      if (response.statusCode == 200) {
        Loaders.successSnackBar(
            title: 'Success',
            message: response.body.toString(),
            icon: Iconsax.archive_book_copy);
        final ctrl = Get.put(JournalController());
        ctrl.fetchAllJournals();
        final allQuotes = Get.put(AllQuotesController());
        allQuotes.fetchAllQuotes();
      } else if (response.statusCode == 403) {
        Loaders.warningSnackBar(
            title: 'Warring',
            message: 'you can not delete the General quotebook');
      } else {
        Loaders.errorSnackBar(
            title: 'Error',
            message: 'Failed to delete journal: ${response.statusCode}');
        print('Error delete journal body ' + response.body);
      }
    } catch (error) {
      Loaders.errorSnackBar(
          title: 'Error Catched on delete journal',
          message: 'An error occurred: $error');
    } finally {
      update();
    }
  }

  Future<void> addQuoteToJournal(int journalId, int quoteId) async {
    try {
      print(quoteId.toString() + '   ' + journalId.toString());
      print('$baseUrl/addToQb/$quoteId/$journalId');
      final response = await http
          .get(Uri.parse('$baseUrl/addToQb/$quoteId/$journalId'), headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${GetStorage().read('TOKEN')}',
        'Connection': 'keep-alive',
        'Accept-Encoding': 'gzip, deflate, br',
      });
      if (response.statusCode == 200) {
        Loaders.customToast(
          message: response.body.toString(),
          color: lightBrown.withOpacity(0.2),
        );
      } else {
        print(response.body);
        Loaders.errorSnackBar(
          title: 'Error',
          message: 'Failed to add quote to journal',
        );
      }
    } catch (e) {
      Loaders.errorSnackBar(
        title: 'Error',
        message: 'An error occurred while adding the quote to the journal',
      );
    }
  }

  Future<void> removeSelectedQuotesFromJournal(
      int journalId, List<int> quoteIds) async {
    try {
      final url = '$baseUrl/removeQb/$journalId';
      // var bodyData = selectedQuotesToDelete
      //     .asMap()
      //     .entries
      //     .map((entry) => 'ids[${entry.key}]:${entry.value}')
      // .join('&');
      final body = {'ids': quoteIds};

      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${GetStorage().read('TOKEN')}',
          'Connection': 'keep-alive',
          'Accept-Encoding': 'gzip, deflate, br',
        },
        body: json.encode(body),
      );

      if (response.statusCode == 200) {
        print(response.body.toString());
        Loaders.successSnackBar(
            title: 'Success ',
            message: 'quotes removed successfully from journal');

        // journalQuotes.removeWhere((quote) => quoteIds.contains(quote.quoteId));
        final ctrl = Get.put(JournalController());
        ctrl.fetchJournalQuotes(journalId);
        selectedQuotesToRemove.clear();
        isRemoveMode(false);
      } else if (response.statusCode == 403) {
        Loaders.warningSnackBar(
            title: 'Note', message: 'you can not update the General quotebook');
      } else {
        Loaders.errorSnackBar(title: 'Err ', message: response.body.toString());
      }
    } catch (e) {}
  }

  String extractImageName(String imagePath) {
    return p.basenameWithoutExtension(imagePath);
  }
}
