import 'package:booktaste/common/widgets/appbar/appbar.dart';
import 'package:booktaste/common/widgets/images/network_image.dart';
import 'package:booktaste/user/user_book_request/book_request_model.dart';
import 'package:booktaste/user/user_book_request/user_book_request_controller.dart';
import 'package:booktaste/utils/constans/images.dart';
import 'package:booktaste/utils/constans/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RequestDetailsPage extends StatelessWidget {
  final String requestId;

  RequestDetailsPage({required this.requestId});

  final controller = Get.put(UserBookRequestController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: Text("Request Details"),
        showBackArrow: true,
      ),
      body: FutureBuilder<UserBookRequest?>(
        future: controller.fetchRequestDetails(requestId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError || snapshot.data == null) {
            return Center(child: Text("Failed to load details."));
          } else {
            final details = snapshot.data!;
            if (details is DeletedRequest) {
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(Sizes.defaultSpace),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Request ID: ${details.id}",
                          style: TextStyle(fontSize: 24)),
                      SizedBox(height: Sizes.md),
                      Text("Status: ${details.status ?? 'Unknown'}",
                          style: TextStyle(fontSize: 18)),
                      Text("Book titel: ${details.bookName ?? 'Unknown'}",
                          style: TextStyle(fontSize: 18)),
                      Text("Author: ${details.author ?? 'Unknown'}",
                          style: TextStyle(fontSize: 18)),
                    ],
                  ),
                ),
              );
            }
            if (details is ApprovedRequest) {
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(Sizes.defaultSpace),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Request ID: ${details.id}",
                          style: TextStyle(fontSize: 24)),
                      SizedBox(height: Sizes.md),
                      SizedBox(
                        width: 100,
                        height: 150,
                        child: MyNetworkImage(
                            shWidth: 100,
                            shHeight: 150,
                            notFoundImage: Images.defaultBookCover,
                            imageUrl: '${details.book?.cover}',
                            fit: BoxFit.contain),
                      ),
                      SizedBox(height: Sizes.md),
                      Text("Book Title: ${details.book?.name ?? 'Unknown'}",
                          style: TextStyle(fontSize: 18)),
                      Text("Book Author: ${details.book?.writer ?? 'Unknown'}",
                          style: TextStyle(fontSize: 18)),
                      Text("Book Language: ${details.book?.lang ?? 'Unknown'}",
                          style: TextStyle(fontSize: 18)),
                    ],
                  ),
                ),
              );
            }

            return Center(child: Text("Unknown request type."));
          }
        },
      ),
    );
  }
}
