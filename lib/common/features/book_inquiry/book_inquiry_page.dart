import 'package:booktaste/common/features/book_inquiry/inquiry_widgets/inquiry_with_reply_card.dart';
import 'package:booktaste/common/features/book_inquiry/inquiry_widgets/not_replied_inquiries_page.dart';
import 'package:booktaste/common/widgets/appbar/appbar.dart';
import 'package:booktaste/data/services/role.manager.dart';
import 'package:booktaste/utils/constans/images.dart';
import 'package:booktaste/utils/constans/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import '../../../controllers/inquiry/inquiry_controller.dart';

class BookInquiriesPage extends StatelessWidget {
  final String bookId;

  BookInquiriesPage({super.key, required this.bookId});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(InquiryController());
    controller.fetchBookInquiries(bookId.toString());
    controller.fetchUserInquiries();
    controller.bookId.value = bookId.toString();
    return Scaffold(
      appBar: MyAppBar(
        title: Text('Inquiries'),
        showBackArrow: true,
        actions: [
          FutureBuilder<bool>(
            future: isUser(),
            builder: (builder, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                final user = snapshot.data;
                return user == false
                    ? IconButton(
                        onPressed: () {
                          Get.to(() => NotRepliedInquiriesPage(
                                bookId: bookId.toString(),
                              ));
                        },
                        icon: Icon(Iconsax.message_question_copy),
                      )
                    : SizedBox();
              }
            },
          ),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        } else if (controller.bookInquiriesList.isEmpty) {
          return Padding(
            padding: const EdgeInsets.all(Sizes.md),
            child: Column(
              children: [
                Text(
                  'No Inquiries on this book yet..',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                Center(child: Image.asset(Images.quoteCoffee)),
              ],
            ),
          );
        } else {
          return ListView.builder(
            itemCount: controller.bookInquiriesList.length,
            itemBuilder: (context, index) {
              final inquiry = controller.bookInquiriesList[index];
              return InquiryWithReplyCard(
                bookId: controller.bookId.value,
                inquiry: inquiry,
              );
            },
          );
        }
      }),
    );
  }
}
