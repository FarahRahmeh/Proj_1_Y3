import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'challenge_controller.dart';

class GenreDetailsPage extends StatelessWidget {
  final controller = Get.find<ChallengeController>();
  final String challengeId;

  GenreDetailsPage({required this.challengeId});

  @override
  Widget build(BuildContext context) {
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   controller.fetchChallengeDetails(challengeId);
    // });

    return Scaffold(
      appBar: AppBar(
        title: Text('Genre Details'),
      ),
      body: Obx(() {
        final genre = controller.genreDetails.value;
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        } else if (genre != null) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Genre: ${genre.genre}',
                    style:
                        TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                SizedBox(height: 16),
                // Image.network('http://127.0.0.1:8000/${genre.image}'),
              ],
            ),
          );
        } else {
          return Center(child: Text('No genre details available.'));
        }
      }),
    );
  }
}
