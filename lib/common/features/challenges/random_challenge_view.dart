import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'challenge_controller.dart';

class BookDetailsPage extends StatelessWidget {
  final ChallengeController controller = Get.find<ChallengeController>();
  final String challengeId;

  BookDetailsPage({required this.challengeId});

  @override
  Widget build(BuildContext context) {
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   controller.fetchChallengeDetails(challengeId);
    // });

    return Scaffold(
      appBar: AppBar(
        title: Text('Book Details'),
      ),
      body: Obx(() {
        final book = controller.bookDetails.value;
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        } else if (book != null) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(book.name,
                    style:
                        TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                SizedBox(height: 16),
                Text('Author: ${book.writer}', style: TextStyle(fontSize: 18)),
                SizedBox(height: 16),
                Text('Summary:',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                Text(book.summary),
                SizedBox(height: 16),
                Text('Pages: ${book.pages}', style: TextStyle(fontSize: 18)),
                SizedBox(height: 16),
                Text('Published At: ${book.publicationYear}',
                    style: TextStyle(fontSize: 18)),
              ],
            ),
          );
        } else {
          return Center(child: Text('No book details available.'));
        }
      }),
    );
  }
}
