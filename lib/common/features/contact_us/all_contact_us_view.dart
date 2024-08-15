import 'package:booktaste/admin/admin_contact_us/admin_reply_contact_message_view.dart';
import 'package:booktaste/common/features/contact_us/contact_message_details_view.dart';
import 'package:booktaste/common/features/contact_us/contact_us_widgets/message_with_reply_card.dart';
import 'package:booktaste/common/widgets/appbar/appbar.dart';
import 'package:booktaste/controllers/contact_us/contact_us_controller.dart';
import 'package:booktaste/data/services/role.manager.dart';
import 'package:booktaste/user/user_contact_us/user_send_contact_message_view.dart';
import 'package:booktaste/utils/constans/images.dart';
import 'package:booktaste/utils/constans/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class AllContactUsPage extends StatelessWidget {
  final controller = Get.put(ContactController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: Text("Contact messages"),
        showBackArrow: true,
        actions: [
          // IconButton(
          //   icon: Icon(Iconsax.send_1_copy),
          //   onPressed: () async {
          //     final user = await isUser();
          //     if (user == true) {
          //       Get.to(() => SendContactView());
          //     }
          //   },
          // ),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        } else if (controller.contactUsMessages.isEmpty) {
          return Padding(
            padding: const EdgeInsets.all(Sizes.md),
            child: Column(
              children: [
                Text(
                  'no contact messages yet...',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                Center(child: Image.asset(Images.quoteCoffee)),
              ],
            ),
          );
        }
        return ListView.builder(
            itemCount: controller.contactUsMessages.length,
            itemBuilder: (context, index) {
              var contactUs = controller.contactUsMessages[index];
              return MessageWithReplyCard(contactUs: contactUs);
              // ListTile(
              //   title: Text("message: ${message.message}"),
              //   subtitle: Text("reply: ${message.reply ?? 'No reply'}"),
              //   trailing: Row(
              //     mainAxisSize: MainAxisSize.min,
              //     children: [
              //       IconButton(
              //         icon: Icon(Iconsax.maximize_4_copy),
              //         onPressed: () {
              //           Get.to(
              //             () => ContactDetailsPage(
              //               id: message.id.toString(),
              //             ),
              //           );
              //         },
              //       ),
              //       IconButton(
              //         icon: Icon(Iconsax.send_1_copy),
              //         onPressed: () async {
              //           final user = await isUser();
              //           if (user == false) {
              //             Get.to(() => ReplyContactView(
              //                   id: message.id.toString(),
              //                 ));
              //           }
              //         },
              //       ),
              //       IconButton(
              //         icon: Icon(Iconsax.edit_2_copy),
              //         onPressed: () async {
              //           final user = await isUser();
              //           Get.to(
              //             () => user == false
              //                 ? ReplyContactView(
              //                     contactMessage: message,
              //                   )
              //                 : 
              // SendContactView(
              //                     contactMessage: message,
              //                   ),
              //           );
              //         },
              //       ),
              //       IconButton(
              //         icon: Icon(Icons.delete),
              //         onPressed: () async {
              //           final user = await isUser();
              //           Get.defaultDialog(
              //             title: "Confirm deleting",
              //             middleText: user == false
              //                 ? "Are you sure you want to delete this reply?"
              //                 : "Are you sure you want to delete this message?",
              //             onCancel: () {},
              //             onConfirm: () {
              //               controller
              //                   .deleteContact(message.id.toString());
              //             },
              //           );
              //         },
              //       ),
              //     ],
              //   ),
              // );
            });
      }),
    );
  }
}
