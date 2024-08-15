import 'package:booktaste/common/features/contact_us/contact_us_widgets/admin_reply_card.dart';
import 'package:booktaste/common/features/contact_us/contact_us_widgets/user_message_card.dart';
import 'package:booktaste/common/widgets/custom_shapes/Containers/rounded_container.dart';
import 'package:booktaste/controllers/contact_us/contact_us_controller.dart';
import 'package:booktaste/models/contact_us_model.dart';
import 'package:booktaste/utils/constans/colors.dart';
import 'package:booktaste/utils/constans/sizes.dart';
import 'package:booktaste/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MessageWithReplyCard extends StatelessWidget {
  MessageWithReplyCard({super.key, required this.contactUs});
  final ContactUs contactUs;

  final controller = Get.put(ContactController());

  @override
  Widget build(BuildContext context) {
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
            backgroundColor:
                dark ? lightBrown.withOpacity(0.4) : darkBrown.withOpacity(0.2),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: Sizes.spaceBtwItems,
                ),

                ///!Message
                UserMessageCard(
                  contactUs: contactUs,
                ),
                // SizedBox(
                //   height: contactUs.repliedBy != null ? Sizes.spaceBtwItems : 0,
                // ),
                //! Company Reply
                contactUs.repliedBy != null
                    ? AdminReplyCard(
                        contactUs: contactUs,
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
