import 'package:booktaste/common/features/book_inquiry/admin_send_reply_inquiry_view.dart';
import 'package:booktaste/common/features/book_inquiry/user_send_inquiry_view.dart';
import 'package:booktaste/controllers/inquiry/inquiry_controller.dart';
import 'package:booktaste/data/services/role.manager.dart';
import 'package:booktaste/models/inquiry_model.dart';
import 'package:booktaste/utils/constans/colors.dart';
import 'package:booktaste/utils/constans/images.dart';
import 'package:booktaste/utils/constans/sizes.dart';
import 'package:booktaste/utils/helpers/helper_functions.dart';
import 'package:booktaste/utils/popups/loaders.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:read_more_text/read_more_text.dart';

class UserInquiryCard extends StatelessWidget {
  UserInquiryCard({
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
                                inquiry.userName.toString(),
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .apply(
                                        color: dark ? lightBrown : darkBrown),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Text(
                        inquiry.createdAt!
                            .toLocal()
                            .toString()
                            .substring(0, 16),
                        // inquiry.createdAt!.year.toString() +
                        //     ' - ' +
                        //     inquiry.createdAt!.month.toString() +
                        //     ' - ' +
                        //     inquiry.createdAt!.day.toString(),
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: Sizes.spaceBtwItems,
                  ),
                  ReadMoreText(
                    inquiry.inquiry.toString(),
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
                          ? FutureBuilder<bool>(
                              future: controller.isUserInquiry(inquiry),
                              builder: (context, snapshot) {
                                final isUserInquiry = snapshot.data ?? false;
                                if (isUserInquiry) {
                                  return Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      inquiry.repliedBy == null
                                          ? IconButton(
                                              onPressed: () =>
                                                  Get.to(() => SendInquiryView(
                                                        inquiryMessage: inquiry,
                                                        userMessage: inquiry,
                                                        bookId:
                                                            bookId.toString(),
                                                      )),
                                              icon: const Icon(
                                                  Iconsax.edit_2_copy,
                                                  size: 20),
                                            )
                                          : SizedBox(),
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
                                      )
                                    ],
                                  );
                                }
                                return SizedBox.shrink();
                              },
                            )
                          : SizedBox(),
                      user == false
                          ? IconButton(
                              onPressed: () {
                                if (inquiry.reply == null) {
                                  Get.to(() => AdminReplyInquiryView(
                                        inquiryId: inquiry.id.toString(),
                                        userMessage: inquiry,
                                        bookId: bookId.toString(),
                                      ));
                                } else {
                                  Loaders.customToast(
                                      message:
                                          '${inquiry.repliedBy.toString()} replied to this message');
                                }
                              },
                              icon: Icon(
                                Iconsax.message_copy,
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
