import 'package:booktaste/admin/admin_book_request/admin_book_request_model.dart';
import 'package:booktaste/admin/admin_book_request/book_request_widgets/admin_book_request_tile.dart';
import 'package:booktaste/common/widgets/appbar/appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'admin_book_request_controller.dart';

class AdminBookRequestDetailsView extends StatelessWidget {
  final AdminBookRequestController controller =
      Get.put(AdminBookRequestController());
  final String bookRequestId;

  AdminBookRequestDetailsView({super.key, required this.bookRequestId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: Text('Book Request Details'),
        showBackArrow: true,
      ),
      body: FutureBuilder<AdminBookRequest?>(
          future: controller.fetchRequestDetails(bookRequestId),
          builder: (builder, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              var request = snapshot.data; //! THE REQUEST
              return SingleChildScrollView(
                child: AdminBookRequestTile(
                  request: request as AdminBookRequest,
                  details: true,
                ),
              );
              // ListTile(
              //   title: Text('Book Title: ' + request!.book!.name.toString()),
              //   subtitle: Text('From: ' + request.requestOwnerEmail.toString()),
              //   trailing: IconButton(
              //     icon: Icon(Iconsax.edit_2_copy),
              //     onPressed: () {
              //       //! change state
              //       MyDialogs.defaultDialog(
              //           title: 'change state',
              //           context: context,
              //           content: SingleChildScrollView(
              //             child: Column(
              //               children: [
              //                 Obx(
              //                   () => ListTile(
              //                     title: Text('Accept'),
              //                     leading: Radio<String>(
              //                       value: 'accept',
              //                       groupValue: controller.approve.value,
              //                       onChanged: (String? value) {
              //                         controller.setApprove(value!);
              //                       },
              //                     ),
              //                   ),
              //                 ),
              //                 Obx(
              //                   () => ListTile(
              //                     title: Text('Reject'),
              //                     leading: Radio<String>(
              //                       value: 'notAccepted',
              //                       groupValue: controller.approve.value,
              //                       onChanged: (String? value) {
              //                         controller.setApprove(value!);
              //                       },
              //                     ),
              //                   ),
              //                 ),
              //               ],
              //             ),
              //           ),
              //           confirmText: 'OK',
              //           onConfirm: () {
              //             controller.changeBookRequestState(
              //                 bookRequestId, controller.approve.value);
              //             Get.back();
              //           });
              //     },
              //   ),
              // );
            }
          }),
    );
  }
}
