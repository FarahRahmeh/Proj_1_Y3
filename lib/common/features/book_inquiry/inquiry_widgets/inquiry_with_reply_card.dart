import 'package:booktaste/common/features/book_inquiry/inquiry_widgets/admin_inquiry_reply_card.dart';
import 'package:booktaste/common/features/book_inquiry/inquiry_widgets/user_inquiry_card.dart';
import 'package:booktaste/common/widgets/custom_shapes/Containers/rounded_container.dart';
import 'package:booktaste/controllers/inquiry/inquiry_controller.dart';
import 'package:booktaste/models/inquiry_model.dart';
import 'package:booktaste/utils/constans/colors.dart';
import 'package:booktaste/utils/constans/sizes.dart';
import 'package:booktaste/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InquiryWithReplyCard extends StatelessWidget {
  InquiryWithReplyCard({super.key, required this.inquiry, this.bookId});
  final Inquiry inquiry;
  final String? bookId;

  final controller = Get.put(InquiryController());

  @override
  Widget build(BuildContext context) {
    controller.bookId.value = bookId.toString();
    final dark = HelperFunctions.isDarkMode(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Sizes.defaultSpace),
      child: Column(
        children: [
          //!Divider
          Divider(
            color: dark ? beige2 : MyColors.grey,
          ),
          //! the support message with reply card
          RoundedContainer(
            radius: 14,
            padding: EdgeInsets.all(10),
            backgroundColor: dark
                ? lightBrown.withOpacity(0.4)
                : lightBrown.withOpacity(0.2),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: Sizes.spaceBtwItems,
                ),

                ///!Message
                UserInquiryCard(
                  inquiry: inquiry,
                  bookId: bookId.toString(),
                ),
                // SizedBox(
                //   height: contactUs.repliedBy != null ? Sizes.spaceBtwItems : 0,
                // ),
                //! Company Reply
                inquiry.repliedBy != null
                    ? AdminInquiryReplyCard(
                        inquiry: inquiry,
                        bookId: bookId.toString(),
                      )
                    : SizedBox.shrink()
              ],
            ),
          ),
        ],
      ),
    );
  }
}
