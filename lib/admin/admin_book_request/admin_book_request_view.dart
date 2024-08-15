import 'package:booktaste/admin/admin_book_request/book_request_widgets/admin_book_request_tile.dart';
import 'package:booktaste/common/widgets/appbar/appbar.dart';
import 'package:booktaste/utils/constans/images.dart';
import 'package:booktaste/utils/constans/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'admin_book_request_controller.dart';

class AdminBookRequestsView extends StatelessWidget {
  final controller = Get.put(AdminBookRequestController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: Text('Admin Book Requests'),
        showBackArrow: true,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return CircularProgressIndicator();
        } else if (controller.adminBookRequests.isEmpty) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(Sizes.md),
              child: Column(
                children: [
                  Center(child: Image.asset(Images.quoteCoffee)),
                  Text(
                    'No Book Requests ..',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
          );
        } else {
          return ListView.builder(
            itemCount: controller.adminBookRequests.length,
            itemBuilder: (context, index) {
              var request = controller.adminBookRequests[index];
              return AdminBookRequestTile(
                request: request,
                details: false,
              );
              // return ListTile(
              //   title: Text('Book Title: ' + request.book!.name.toString()),
              //   subtitle: Text('From: ' + request.requestOwnerEmail.toString()),
              //   trailing:
              // IconButton(
              //     icon: Icon(Icons.arrow_forward),
              //     onPressed: () {
              //       Get.to(() => AdminBookRequestDetailsView(
              //             bookRequestId: request.id.toString(),
              //           ));
              //     },
              //   ),
              // );
            },
          );
        }
      }),
    );
  }
}
