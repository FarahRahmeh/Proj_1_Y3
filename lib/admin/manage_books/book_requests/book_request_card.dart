import 'package:booktaste/admin/manage_books/book_requests/edit_book_request_page.dart';
import 'package:booktaste/common/widgets/custom_shapes/Containers/rounded_container.dart';
import 'package:booktaste/user/user_all_books/all_books_model.dart';
import 'package:booktaste/utils/constans/colors.dart';
import 'package:booktaste/utils/constans/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../../../utils/helpers/helper_functions.dart';

class BookRequestCard extends StatelessWidget {
  const BookRequestCard(
      {super.key, this.selectedRequest = false, required this.bookRequest});
  final bool selectedRequest;
  final AllBooks bookRequest;
  @override
  Widget build(BuildContext context) {
    // final bkReqCtrl = Get.put(BookRequestController());
    // bkReqCtrl.fetchBookRequest();
    final dark = HelperFunctions.isDarkMode(context);

    return RoundedContainer(
      width: double.infinity,
      padding: EdgeInsets.all(Sizes.md),

      backgroundColor: dark ? lightBrown.withOpacity(0.6) : gray,
      // backgroundColor: selectedRequest
      //     ? MyColors.primary.withOpacity(0.5)
      //     : Colors.transparent,
      // borderColor: selectedRequest
      //     ? Colors.transparent
      //     : dark
      //         ? MyColors.darkGrey
      //         : gray,
      margin: EdgeInsets.only(bottom: Sizes.spaceBtwItems),
      child: Stack(
        children: [
          //! Edit
          Positioned(
            right: 5,
            top: 0,
            child: InkWell(
              onTap: () => Get.to(() => EditBookRequestPage()),
              child: Icon(
                Iconsax.maximize_4_copy,
              ),
            ),
          ),
          //! selected
          // Positioned(
          //   right: 5,
          //   top: 0,
          //   child: Icon(
          //     selectedAddress ? Iconsax.tick_circle : null,
          //     color: selectedAddress
          //         ? dark
          //             ? MyColors.light
          //             : MyColors.dark.withOpacity(0.5)
          //         : null,
          //   ),
          // ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '..',
                //bkReqCtrl.book.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              SizedBox(
                height: Sizes.sm / 2,
              ),
              Text(
                'Whatever phone number here',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(
                height: Sizes.sm / 2,
              ),
              Text(
                'Whatever address here .... ',
                maxLines: 2,
                softWrap: true,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
