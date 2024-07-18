import 'package:booktaste/admin/manage_books/book_requests/book_request_card.dart';
import 'package:booktaste/common/widgets/appbar/appbar.dart';
import 'package:booktaste/user/user_all_books/all_books_controller.dart';
import 'package:booktaste/utils/constans/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BookRequestsPage extends StatelessWidget {
  const BookRequestsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final allbookscontroller = Get.put(AllBooksController());
    allbookscontroller.fetchAllBooks();
    return Scaffold(
      appBar: MyAppBar(
        showBackArrow: true,
        title: Text(
          'Book Requests',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(Sizes.defaultSpace),
          child: SizedBox(
                    height: 120,
                    child: ListView.separated(
                      itemCount: allbookscontroller.booksList.length,
                      scrollDirection: Axis.horizontal,
                      separatorBuilder: (context, index) => SizedBox(
                        width: Sizes.spaceBtwItems,
                      ),
                      itemBuilder: (context, index)  {
                        return BookRequestCard(
                          bookRequest: allbookscontroller.booksList[index]);
                          }
                    ),
                  ),
          // child: Column(
          //   children: [
          //     BookRequestCard(selectedRequest: false),
          //     BookRequestCard(selectedRequest: false),
          //     BookRequestCard(selectedRequest: true),
          //     BookRequestCard(selectedRequest: false),
          //   ],
          // ),
        ),
      ),
    );
  }
}
