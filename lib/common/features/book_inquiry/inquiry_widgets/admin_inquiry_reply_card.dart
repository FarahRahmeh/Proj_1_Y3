import 'package:booktaste/common/widgets/custom_shapes/Containers/rounded_container.dart';
import 'package:booktaste/controllers/inquiry/inquiry_controller.dart';
import 'package:booktaste/data/services/role.manager.dart';
import 'package:booktaste/models/inquiry_model.dart';
import 'package:booktaste/utils/constans/colors.dart';
import 'package:booktaste/utils/constans/sizes.dart';
import 'package:booktaste/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:read_more_text/read_more_text.dart';

import '../admin_send_reply_inquiry_view.dart';

class AdminInquiryReplyCard extends StatelessWidget {
  AdminInquiryReplyCard({
    super.key,
    required this.inquiry,
    this.bookId,
  });
  final Inquiry inquiry;
  final String? bookId;
  final controller = Get.put(InquiryController());

  @override
  Widget build(BuildContext context) {
    controller.bookId.value = bookId.toString();
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
                  color: dark ? MyColors.black.withOpacity(0.6) : gray,
                  height: 20,
                ),
                RoundedContainer(
                  backgroundColor:
                      dark ? MyColors.black.withOpacity(0.6) : gray,
                  child: Padding(
                    padding: EdgeInsets.all(Sizes.md),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              inquiry.repliedBy.toString(),
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
                          inquiry.reply.toString(),
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
                                          controller.deleteInquiry(
                                              inquiry.id.toString());
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
                                      Get.to(() => AdminReplyInquiryView(
                                            InquiryMessage: inquiry,
                                            userMessage: inquiry,
                                            bookId: bookId.toString(),
                                          ));
                                    },
                                    icon: Icon(
                                      Iconsax.edit_2_copy,
                                      size: 20,
                                    ),
                                  ),
                                  // IconButton(
                                  //   onPressed: () {
                                  //     // Get.to(
                                  //     //   () => ContactDetailsPage(
                                  //     //     id: inquiry.id.toString(),
                                  //     //   ),
                                  //     // );
                                  //   },
                                  //   icon: Icon(
                                  //     Iconsax.maximize_3_copy,
                                  //     size: 20,
                                  //   ),
                                  // ),
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
