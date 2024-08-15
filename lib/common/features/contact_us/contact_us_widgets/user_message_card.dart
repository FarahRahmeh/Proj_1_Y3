import 'package:booktaste/controllers/contact_us/contact_us_controller.dart';
import 'package:booktaste/data/services/role.manager.dart';
import 'package:booktaste/models/contact_us_model.dart';
import 'package:booktaste/user/user_contact_us/user_send_contact_message_view.dart';
import 'package:booktaste/utils/constans/colors.dart';
import 'package:booktaste/utils/constans/images.dart';
import 'package:booktaste/utils/constans/sizes.dart';
import 'package:booktaste/utils/helpers/helper_functions.dart';
import 'package:booktaste/utils/popups/loaders.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:read_more_text/read_more_text.dart';

import '../../../../admin/admin_contact_us/admin_reply_contact_message_view.dart';
import '../contact_message_details_view.dart';

class UserMessageCard extends StatelessWidget {
  UserMessageCard({
    super.key,
    required this.contactUs,
  });
  final ContactUs contactUs;
  final controller = Get.put(ContactController());

  @override
  Widget build(BuildContext context) {
    final dark = HelperFunctions.isDarkMode(context);

    return FutureBuilder<bool>(
        future: isUser(),
        builder: (builder, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            final user = snapshot.data;
            return Container(
              padding: EdgeInsets.all(Sizes.sm),
              decoration: BoxDecoration(
                color: dark ? MyColors.black : offWhite.withOpacity(0.8),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: lightBrown.withOpacity(0.8),
                            backgroundImage: AssetImage(Images.user),
                          ),
                          SizedBox(
                            width: Sizes.spaceBtwItems,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                contactUs.userName.toString(),
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .apply(color: dark ? lightBrown : brown),
                              ),
                              Text(
                                contactUs.email.toString(),
                                style: Theme.of(context)
                                    .textTheme
                                    .labelLarge!
                                    .apply(color: dark ? lightBrown : brown),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Text(
                        contactUs.createdAt!.year.toString() +
                            ' - ' +
                            contactUs.createdAt!.month.toString() +
                            ' - ' +
                            contactUs.createdAt!.day.toString(),
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: Sizes.spaceBtwItems,
                  ),
                  ReadMoreText(
                    contactUs.message.toString(),
                    numLines: 3,
                    readMoreText: 'Read more',
                    readLessText: 'Less',
                    readMoreIconColor: dark ? lightBrown : pinkish,
                    readMoreTextStyle: TextStyle(
                        color: dark ? lightBrown : brown, fontSize: 12),
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      user == true
                          ? IconButton(
                              onPressed: () {
                                Get.defaultDialog(
                                  title: "Confirm deleting",
                                  middleText: user == false
                                      ? "Are you sure you want to delete this reply?"
                                      : "Are you sure you want to delete this message?",
                                  onCancel: () {},
                                  onConfirm: () {
                                    controller
                                        .deleteContact(contactUs.id.toString());
                                    Get.back();
                                  },
                                );
                              },
                              icon: Icon(
                                Iconsax.trash_copy,
                                size: 20,
                              ),
                            )
                          : SizedBox(),
                      user == false
                          ? IconButton(
                              onPressed: () {
                                if (contactUs.reply == null) {
                                  Get.to(() => ReplyContactView(
                                        id: contactUs.id.toString(),
                                        userMessage: contactUs,
                                      ));
                                } else {
                                  Loaders.customToast(
                                      message:
                                          '${contactUs.repliedBy.toString()} replied to this message');
                                }
                              },
                              icon: Icon(
                                Iconsax.message_copy,
                                size: 20,
                              ),
                            )
                          : contactUs.reply == null
                              ? IconButton(
                                  onPressed: () {
                                    Get.to(() => SendContactView(
                                          contactMessage: contactUs,
                                          userMessage: contactUs,
                                        ));
                                  },
                                  icon: Icon(
                                    Iconsax.edit_2_copy,
                                    size: 20,
                                  ),
                                )
                              : SizedBox(),
                      user == true
                          ? IconButton(
                              onPressed: () {
                                Get.to(
                                  () => ContactDetailsPage(
                                    id: contactUs.id.toString(),
                                  ),
                                );
                              },
                              icon: Icon(
                                Iconsax.maximize_3_copy,
                                size: 20,
                              ),
                            )
                          : SizedBox(),
                    ],
                  )
                ],
              ),
            );
          }
        });
  }
}
