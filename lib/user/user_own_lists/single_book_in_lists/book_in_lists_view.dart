import 'package:booktaste/user/user_own_lists/single_book_in_lists/book_in_lists_controller.dart';
import 'package:booktaste/utils/constans/colors.dart';
import 'package:booktaste/utils/constans/images.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class BookInListsView extends StatelessWidget {
  BookInListsView({super.key, required this.bookid});
  final String bookid;
  final bookController = Get.put(BookListsController());

  @override
  Widget build(BuildContext context) {
    bookController.fetchBookLists(bookid.toString());
    return Scaffold(
      appBar: AppBar(title: Text('Book Lists')),
      body: Obx(() {
        if (bookController.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        } else {
          return ListView.builder(
            itemCount: bookController.bookLists.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(bookController.bookLists[index]),
              );
            },
          );
        }
      }),
    );
  }

  void showJournalSelectionDialog(BuildContext context) {
    bookController.fetchBookLists(bookid.toString());

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Obx(() {
          if (bookController.isLoading.value) {
            return Center(child: CircularProgressIndicator());
          } else if (bookController.bookLists.isEmpty) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  Images.shelves,
                  width: 90,
                  height: 90,
                ),
                Text('No list'),
              ],
            );
          }
          return AlertDialog(
            title: Text('This Book Exist in:'),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.start,
                  //   children: [
                  //     Text('Add this quote to journal :'),
                  //     SizedBox(
                  //       height: Sizes.md,
                  //     )
                  //   ],
                  // ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        Images.shelves,
                        width: 90,
                        height: 90,
                      ),
                    ],
                  ),
                  Column(
                    children: bookController.bookLists.map((list) {
                      return ListTile(
                        leading: Icon(
                          Iconsax.document_like_copy,
                          color: brown,
                        ),
                        title: Text(list),
                      );
                    }).toList(),
                  ),
                  TextButton(
                    onPressed: () => Get.back(),
                    child: Text('Cancel'),
                  ),
                ],
              ),
            ),
          );
        });
      },
    );
  }
}
