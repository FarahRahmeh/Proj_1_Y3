import 'package:booktaste/common/widgets/appbar/appbar.dart';
import 'package:booktaste/user/user_book_request/book_request_widgets/book_request_tile_view.dart';
import 'package:booktaste/user/user_book_request/user_book_request_controller.dart';
import 'package:booktaste/utils/constans/images.dart';
import 'package:booktaste/utils/constans/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserBookRequestsPage extends StatelessWidget {
  final controller = Get.put(UserBookRequestController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: Text("Book Requests"),
        showBackArrow: true,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        } else if (controller.requests.isEmpty) {
          return Padding(
            padding: const EdgeInsets.all(Sizes.md),
            child: Column(
              children: [
                Text(
                  'No Book Requests yet  ..',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                Center(child: Image.asset(Images.quoteCoffee)),
              ],
            ),
          );
        } else {
          return ListView.builder(
            itemCount: controller.requests.length,
            itemBuilder: (context, index) {
              var request = controller.requests[index];
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: Sizes.defaultSpace),
                child: BookRequestTileView(
                  request: request,
                ),
              );
              // if (request is ApprovedRequest) {
              //   return Column(
              //     children: [
              //       ListTile(
              //         title: Text("Request Status: ${request.requestStatus}"),
              //         subtitle:
              //             Text("Book title: ${request.book?.name ?? 'Unknown'}"),
              //         trailing: Row(
              //           mainAxisSize: MainAxisSize.min,
              //           children: [
              //             IconButton(
              //               icon: Icon(Iconsax.maximize_4_copy),
              //               onPressed: () {
              //                 final requestId = request.id;
              //                 Get.to(() => RequestDetailsPage(
              //                     requestId: requestId.toString()));
              //               },
              //             ),
              //             IconButton(
              //               icon: Icon(Icons.delete),
              //               onPressed: () {
              //                 // Confirm delete action
              //                 Get.defaultDialog(
              //                   title: "Confirm Delete",
              //                   middleText:
              //                       "Are you sure you want to delete this request?",
              //                   onCancel: () => Get.back(),
              //                   onConfirm: () {
              //                     controller.deleteRequest(request.id.toString());
              //                     Get.back();
              //                   },
              //                 );
              //               },
              //             ),
              //           ],
              //         ),
              //       ),
              //     ],
              //   );
              // } else if (request is DeletedRequest) {
              //   return ListTile(
              //     title: Text("Request Status: ${request.status}"),
              //     subtitle: Text("Book title: ${request.bookName ?? 'Unknown'}"),
              //     trailing: Row(
              //       mainAxisSize: MainAxisSize.min,
              //       children: [
              //         IconButton(
              //           icon: Icon(Iconsax.maximize_4_copy),
              //           onPressed: () {
              //             final requestId = request.id;
              //             Get.to(() => RequestDetailsPage(
              //                 requestId: requestId.toString()));
              //           },
              //         ),
              //         IconButton(
              //           icon: Icon(Icons.delete),
              //           onPressed: () {
              //             // Confirm delete action
              //             Get.defaultDialog(
              //               title: "Confirm Delete",
              //               middleText:
              //                   "Are you sure you want to delete this request?",
              //               onCancel: () => Get.back(),
              //               onConfirm: () {
              //                 controller.deleteRequest(request.id.toString());
              //                 Get.back(); // Close the dialog
              //               },
              //             );
              //           },
              //         ),
              //       ],
              //     ),
              //   );
              // }
              // return SizedBox.shrink();
            },
          );
        }
      }),
    );
  }
}
