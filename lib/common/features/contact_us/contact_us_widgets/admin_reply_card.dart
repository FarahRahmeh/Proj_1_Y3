import 'package:booktaste/common/features/contact_us/contact_message_details_view.dart';
import 'package:booktaste/common/widgets/custom_shapes/Containers/rounded_container.dart';
import 'package:booktaste/controllers/contact_us/contact_us_controller.dart';
import 'package:booktaste/data/services/role.manager.dart';
import 'package:booktaste/models/contact_us_model.dart';
import 'package:booktaste/utils/constans/colors.dart';
import 'package:booktaste/utils/constans/sizes.dart';
import 'package:booktaste/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:read_more_text/read_more_text.dart';

import '../../../../admin/admin_contact_us/admin_reply_contact_message_view.dart';

class AdminReplyCard extends StatelessWidget {
  AdminReplyCard({
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
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: Sizes.md),
                  width: 5,
                  color: dark
                      ? MyColors.black.withOpacity(0.6)
                      : pinkish.withOpacity(0.4),
                  height: 20,
                ),
                RoundedContainer(
                  backgroundColor: dark
                      ? MyColors.black.withOpacity(0.6)
                      : pinkish.withOpacity(0.4),
                  child: Padding(
                    padding: EdgeInsets.all(Sizes.md),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              contactUs.repliedBy.toString(),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .apply(color: dark ? lightBrown : darkBrown),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: Sizes.sm),
                              child: Icon(
                                Iconsax.verify,
                                color: dark ? lightBrown : darkBrown,
                                size: 20,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: Sizes.spaceBtwItems,
                        ),
                        ReadMoreText(
                          contactUs.reply.toString(),
                          numLines: 2,
                          readMoreText: 'Show more',
                          readLessText: 'Less',
                          readMoreIconColor: pinkish,
                          readMoreTextStyle: TextStyle(color: brown),
                          style: TextStyle(
                              fontWeight: FontWeight.w800, fontSize: 14),
                        ),
                        user == false
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      Get.defaultDialog(
                                        title: "Confirm deleting",
                                        middleText: user == false
                                            ? "Are you sure you want to delete this reply?"
                                            : "Are you sure you want to delete this message?",
                                        onCancel: () {},
                                        onConfirm: () {
                                          controller.deleteContact(
                                              contactUs.id.toString());
                                          Get.back();
                                        },
                                      );
                                    },
                                    icon: Icon(
                                      Iconsax.trash_copy,
                                      size: 20,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      Get.to(() => ReplyContactView(
                                            contactMessage: contactUs,
                                            userMessage: contactUs,
                                          ));
                                    },
                                    icon: Icon(
                                      Iconsax.edit_2_copy,
                                      size: 20,
                                    ),
                                  ),
                                  IconButton(
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
                                  ),
                                ],
                              )
                            : SizedBox.shrink(),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }
        });
  }
}
