import 'package:booktaste/common/features/contact_us/contact_us_widgets/user_message_card.dart';
import 'package:booktaste/common/widgets/appbar/appbar.dart';
import 'package:booktaste/controllers/contact_us/contact_us_controller.dart';
import 'package:booktaste/models/contact_us_model.dart';
import 'package:booktaste/utils/constans/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../../common/features/contact_us/all_contact_us_view.dart';

class SendContactView extends StatelessWidget {
  SendContactView({Key? key, this.contactMessage, this.userMessage})
      : super(key: key) {
    if (contactMessage != null) {
      controller.contact.value = contactMessage!;
    }
  }
  final ContactUs? contactMessage;
  final ContactUs? userMessage;
  final controller = Get.put(ContactController());

  @override
  Widget build(BuildContext context) {
    final messageController = TextEditingController(
        text: contactMessage?.message ?? 'Hello Support Team,..\n');
    if (contactMessage != null) {
      controller.contact.value.message = contactMessage!.message ?? '';
    }
    return Scaffold(
      appBar: MyAppBar(
        title: Text("Contact Us"),
        showBackArrow: true,
        actions: [
          IconButton(
              icon: Icon(Iconsax.messages_3_copy),
              onPressed: () {
                Get.to(
                  () => AllContactUsPage(),
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
                  ? UserMessageCard(contactUs: userMessage as ContactUs)
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
                    if (contactMessage != null) {
                      controller.contact.value.message =
                          messageController.text.trim();
                      controller.updateContactMessage();
                    } else {
                      controller.sendMessage(messageController.text.trim());
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
