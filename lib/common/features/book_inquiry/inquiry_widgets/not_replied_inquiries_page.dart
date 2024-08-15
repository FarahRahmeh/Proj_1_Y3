import 'package:booktaste/common/features/book_inquiry/inquiry_widgets/inquiry_with_reply_card.dart';
import 'package:booktaste/common/widgets/appbar/appbar.dart';
import 'package:booktaste/utils/constans/images.dart';
import 'package:booktaste/utils/constans/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controllers/inquiry/inquiry_controller.dart';

class NotRepliedInquiriesPage extends StatelessWidget {
  final String bookId;

  NotRepliedInquiriesPage({super.key, required this.bookId});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(InquiryController());
    controller.fetchNotRepliedInquiries(bookId.toString());
    controller.bookId.value = bookId.toString();
    return Scaffold(
      appBar: MyAppBar(
        title: Text('Not Replied Inquiries'),
        showBackArrow: true,
      ),
      body: Obx(() {
        if (controller.isNotRepliedLoading.value) {
          return Center(child: CircularProgressIndicator());
        } else if (controller.notRepliedInqs.isEmpty) {
          return Padding(
            padding: const EdgeInsets.all(Sizes.md),
            child: Column(
              children: [
                Text(
                  'All inquiries have been replied.',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                Center(child: Image.asset(Images.quoteCoffee)),
              ],
            ),
          );
        } else {
          return ListView.builder(
            itemCount: controller.notRepliedInqs.length,
            itemBuilder: (context, index) {
              final inquiry = controller.notRepliedInqs[index];
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
