import 'package:booktaste/common/widgets/custom_shapes/Containers/rounded_container.dart';
import 'package:booktaste/user/user_book_request/book_request_model.dart';
import 'package:booktaste/utils/constans/colors.dart';
import 'package:booktaste/utils/constans/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../../../../utils/helpers/helper_functions.dart';
import '../user_book_request_controller.dart';
import '../user_single_request_view.dart';

class BookRequestTileView extends StatelessWidget {
  BookRequestTileView({
    Key? key,
    required this.request,
  }) : super(key: key);

  final UserBookRequest request;
  final controller = Get.put(UserBookRequestController());

  @override
  Widget build(BuildContext context) {
    final dark = HelperFunctions.isDarkMode(context);

    return RoundedContainer(
      width: double.infinity,
      padding: EdgeInsets.all(Sizes.md),
      showBorder: true,
      backgroundColor:
          dark ? MyColors.primary.withOpacity(0.5) : Colors.transparent,
      borderColor: dark ? MyColors.darkGrey : gray,
      margin: EdgeInsets.only(bottom: Sizes.spaceBtwItems),
      child: Stack(children: [
        Positioned(
          right: -10,
          top: -10,
          child: Row(
            children: [
              IconButton(
                icon: Icon(
                  Iconsax.maximize_4_copy,
                  size: 20,
                ),
                color: dark ? MyColors.light : MyColors.dark.withOpacity(0.5),
                onPressed: () {
                  Get.to(() =>
                      RequestDetailsPage(requestId: request.id.toString()));
                },
              ),
              IconButton(
                icon: Icon(
                  Iconsax.trash_copy,
                  size: 20,
                ),
                color: dark ? MyColors.light : MyColors.dark.withOpacity(0.5),
                onPressed: () {
                  Get.defaultDialog(
                    title: "Confirm Delete",
                    middleText: "Are you sure you want to delete this request?",
                    onCancel: () {},
                    onConfirm: () {
                      controller.deleteRequest(request.id.toString());
                      Get.back();
                    },
                  );
                },
              ),
            ],
          ),
        ),
        if (request is ApprovedRequest) ...[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Status: ${(request as ApprovedRequest).requestStatus}",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              SizedBox(height: Sizes.sm / 2),
              Text(
                "Book title: ${(request as ApprovedRequest).book?.name ?? 'Unknown'}",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: Sizes.sm / 2),
              Text(
                "Author: ${(request as ApprovedRequest).book?.writer ?? 'Unknown'}",
                maxLines: 2,
                softWrap: true,
              ),
            ],
          ),
        ] else if (request is DeletedRequest) ...[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Status: ${(request as DeletedRequest).status}",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              SizedBox(height: Sizes.sm / 2),
              Text(
                "Book title: ${(request as DeletedRequest).bookName ?? 'Unknown'}",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: Sizes.sm / 2),
              Text(
                "Book author: ${(request as DeletedRequest).author ?? 'Unknown'}",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              // SizedBox(height: Sizes.sm / 2),
              // Text(
              //   'Whatever address here ....',
              //   maxLines: 2,
              //   softWrap: true,
              // ),
            ],
          ),
        ]
        // else {
        //   SizedBox.shrink(), // Alternative to SizedBox() for clarity
        // },
      ]),
    );
  }
}
