import 'package:booktaste/admin/admin_book_request/admin_book_request_controller.dart';
import 'package:booktaste/admin/admin_book_request/admin_book_request_model.dart';
import 'package:booktaste/admin/admin_book_request/admin_single_request_view.dart';
import 'package:booktaste/common/widgets/custom_shapes/Containers/rounded_container.dart';
import 'package:booktaste/common/widgets/images/network_image.dart';
import 'package:booktaste/utils/constans/colors.dart';
import 'package:booktaste/utils/constans/images.dart';
import 'package:booktaste/utils/constans/sizes.dart';
import 'package:booktaste/utils/popups/dialogs.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../../../../utils/helpers/helper_functions.dart';

class AdminBookRequestTile extends StatelessWidget {
  AdminBookRequestTile({
    super.key,
    required this.request,
    this.details,
  });
  final AdminBookRequest request;
  final bool? details;
  final controller = Get.put(AdminBookRequestController());
  @override
  Widget build(BuildContext context) {
    final dark = HelperFunctions.isDarkMode(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Sizes.defaultSpace),
      child: RoundedContainer(
        width: double.infinity,
        padding: EdgeInsets.all(Sizes.md),
        showBorder: true,
        backgroundColor:
            dark ? MyColors.primary.withOpacity(0.5) : Colors.transparent,
        borderColor: dark ? MyColors.darkGrey : gray,
        margin: EdgeInsets.only(bottom: Sizes.spaceBtwItems),
        child: Stack(
          children: [
            Positioned(
              right: 5,
              top: 0,
              child: details == false
                  ? IconButton(
                      icon: Icon(Iconsax.arrow_right_1_copy),
                      onPressed: () {
                        Get.to(() => AdminBookRequestDetailsView(
                              bookRequestId: request.id.toString(),
                            ));
                      },
                    )
                  : IconButton(
                      icon: Icon(
                        Iconsax.edit_2,
                        color: darkBrown,
                      ),
                      onPressed: () {
                        //! change state
                        MyDialogs.defaultDialog(
                            title: 'change state',
                            context: context,
                            content: SingleChildScrollView(
                              child: Column(
                                children: [
                                  Obx(
                                    () => ListTile(
                                      title: Text('Accept'),
                                      leading: Radio<String>(
                                        value: 'accept',
                                        groupValue: controller.approve.value,
                                        onChanged: (String? value) {
                                          controller.setApprove(value!);
                                        },
                                      ),
                                    ),
                                  ),
                                  Obx(
                                    () => ListTile(
                                      title: Text('Reject'),
                                      leading: Radio<String>(
                                        value: 'notAccepted',
                                        groupValue: controller.approve.value,
                                        onChanged: (String? value) {
                                          controller.setApprove(value!);
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            confirmText: 'OK',
                            onConfirm: () {
                              controller.changeBookRequestState(
                                  request.id.toString(),
                                  controller.approve.value);
                              Get.back();
                            });
                      },
                    ),
            ),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                'From: ' + request.requestOwnerEmail.toString(),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .apply(color: darkBrown),
              ),
              SizedBox(
                height: Sizes.sm / 2,
              ),
              Text(
                'Title: ' + request.book!.name.toString(),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              details == true
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: Sizes.sm / 2,
                        ),
                        Text(
                          'Author: ' + request.book!.writer.toString(),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(
                          height: Sizes.sm / 2,
                        ),
                        Text(
                          'Language: ' + request.book!.lang.toString(),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(
                          height: Sizes.sm / 2,
                        ),
                        Text(
                          'Pages: ' + request.book!.pages.toString(),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(
                          height: Sizes.sm / 2,
                        ),
                        Text(
                          'Published at: ' +
                              request.book!.publicationYear.toString(),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(
                          height: Sizes.sm / 2,
                        ),
                        Text(
                          request.book!.type.toString() == '1'
                              ? 'Type: Novel'
                              : 'Type: Book',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(
                          height: Sizes.sm / 2,
                        ),
                        Text(
                          'Genres: ' + request.book!.genre.toString(),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(
                          height: Sizes.sm / 2,
                        ),
                        Text(
                          'Summary: ' + request.book!.summary.toString(),
                          maxLines: 10,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(
                          height: Sizes.sm / 2,
                        ),
                        SizedBox(
                          height: 140,
                          width: 100,
                          child: MyNetworkImage(
                            imageUrl: request.book!.cover.toString(),
                            notFoundImage: Images.defaultBookCover,
                            shHeight: 140,
                            shWidth: 100,
                          ),
                        ),
                      ],
                    )
                  : SizedBox(),
            ]),
          ],
        ),
      ),
    );
  }
}
