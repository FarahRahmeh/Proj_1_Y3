import 'package:booktaste/common/features/book_inquiry/book_inquiry_page.dart';
import 'package:booktaste/common/features/book_inquiry/inquiry_widgets/user_inquiry_card.dart';
import 'package:booktaste/common/features/contact_us/contact_us_widgets/user_message_card.dart';
import 'package:booktaste/common/widgets/appbar/appbar.dart';
import 'package:booktaste/controllers/inquiry/inquiry_controller.dart';
import 'package:booktaste/models/contact_us_model.dart';
import 'package:booktaste/models/inquiry_model.dart';
import 'package:booktaste/utils/constans/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class SendInquiryView extends StatelessWidget {
  SendInquiryView(
      {Key? key, this.inquiryMessage, this.userMessage, this.bookId})
      : super(key: key) {
    if (inquiryMessage != null) {
      controller.inquiry.value = inquiryMessage!;
    }
  }
  final Inquiry? inquiryMessage;
  final Inquiry? userMessage;
  final String? bookId;
  final controller = Get.put(InquiryController());

  @override
  Widget build(BuildContext context) {
    final messageController = TextEditingController(
        text: inquiryMessage?.inquiry ?? 'I Have a question,..\n');
    if (inquiryMessage != null) {
      controller.inquiry.value.inquiry = inquiryMessage!.inquiry ?? '';
    }
    return Scaffold(
      appBar: MyAppBar(
        title: Text("Send Inquiry"),
        showBackArrow: true,
        actions: [
          IconButton(
              icon: Icon(Iconsax.message_question_copy),
              onPressed: () {
                Get.to(
                  () => BookInquiriesPage(bookId: bookId.toString()),
                );
              }),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(Sizes.md),
        child: SingleChildScrollView(
          child: Column(
            children: [
              userMessage != null
                  ? UserInquiryCard(
                      inquiry: userMessage as Inquiry,
                      bookId: bookId.toString(),
                    )
                  : SizedBox(),
              SizedBox(
                height: Sizes.lg,
              ),
              TextField(
                maxLines: null,
                minLines: 4,
                controller: messageController,
                decoration: InputDecoration(labelText: "Your Message"),
              ),
              SizedBox(height: Sizes.spaceBtwInputFields),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (inquiryMessage != null) {
                      controller.inquiry.value.inquiry =
                          messageController.text.trim();
                      controller.updateInquiry();
                    } else {
                      controller.sendInquiry(
                          messageController.text.trim(),bookId.toString());
                    }
                  },
                  child: Text("Send"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
