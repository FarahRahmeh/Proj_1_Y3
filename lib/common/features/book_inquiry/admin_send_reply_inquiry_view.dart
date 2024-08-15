import 'package:booktaste/common/features/book_inquiry/inquiry_widgets/user_inquiry_card.dart';
import 'package:booktaste/common/widgets/appbar/appbar.dart';
import 'package:booktaste/controllers/inquiry/inquiry_controller.dart';
import 'package:booktaste/models/inquiry_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/constans/sizes.dart';

class AdminReplyInquiryView extends StatelessWidget {
  AdminReplyInquiryView(
      {Key? key,
      this.inquiryId,
      this.InquiryMessage,
      this.userMessage,
      this.bookId})
      : super(key: key) {
    if (InquiryMessage != null) {
      controller.inquiry.value = InquiryMessage!;
    }
  }
  final Inquiry? InquiryMessage;
  final Inquiry? userMessage;
  final controller = Get.put(InquiryController());
  final String? inquiryId;
  final String? bookId;
  @override
  Widget build(BuildContext context) {
    controller.bookId.value = bookId.toString();
    final replyController =
        TextEditingController(text: InquiryMessage?.reply ?? 'Hello\n');
    if (InquiryMessage != null) {
      controller.inquiry.value.reply = InquiryMessage!.reply ?? '';
    }
    return Scaffold(
      appBar: MyAppBar(
        title: Text("Reply To inquiry"),
        showBackArrow: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              userMessage != null
                  ? UserInquiryCard(inquiry: userMessage as Inquiry)
                  : SizedBox(),
              SizedBox(
                height: Sizes.lg,
              ),
              TextField(
                maxLines: null,
                minLines: 3,
                controller: replyController,
                decoration: InputDecoration(labelText: "Your Reply"),
              ),
              SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (InquiryMessage != null) {
                      controller.inquiry.value.reply =
                          replyController.text.trim();
                      controller.updateInquiry();
                    } else {
                      controller.replyToInquiry(
                          replyController.text.trim(), inquiryId.toString());
                      
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

// void _showReplyDialog(BuildContext context, String inquiryId) {
//   final replyController = TextEditingController();

//   MyDialogs.defaultDialog(
//     context: context,
//     title: 'Reply to Inquiry',
//     content: SingleChildScrollView(
//       child: TextField(
//         autofocus: true,
//         maxLines: null,
//         minLines: 4,
//         controller: replyController,
//         decoration: InputDecoration(labelText: "Your Reply Message"),
//       ),
//     ),
//     onConfirm: () {
//       controller.replyToInquiry(replyController.text.trim(), inquiryId);
//     },
//     confirmText: 'Send Reply',
//   );
// }
