import 'package:booktaste/common/features/contact_us/contact_us_widgets/user_message_card.dart';
import 'package:booktaste/common/widgets/appbar/appbar.dart';
import 'package:booktaste/controllers/contact_us/contact_us_controller.dart';
import 'package:booktaste/models/contact_us_model.dart';
import 'package:booktaste/utils/constans/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReplyContactView extends StatelessWidget {
  ReplyContactView({Key? key, this.id, this.contactMessage, this.userMessage})
      : super(key: key) {
    if (contactMessage != null) {
      controller.contact.value = contactMessage!;
    }
  }
  final ContactUs? contactMessage;
  final ContactUs? userMessage;
  final controller = Get.put(ContactController());
  final String? id;

  @override
  Widget build(BuildContext context) {
    final replyController = TextEditingController(
        text: contactMessage?.reply ?? 'Hello Dear User,\n');
    if (contactMessage != null) {
      controller.contact.value.reply = contactMessage!.reply ?? '';
    }
    return Scaffold(
      appBar: MyAppBar(
        title: Text("Reply To message"),
        showBackArrow: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              userMessage != null
                  ? UserMessageCard(contactUs: userMessage as ContactUs)
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
                    if (contactMessage != null) {
                      controller.contact.value.reply =
                          replyController.text.trim();
                      controller.updateContactMessage();
                      Get.back();
                    } else {
                      controller.replyToContactMessage(
                          replyController.text.trim(), id.toString());
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
