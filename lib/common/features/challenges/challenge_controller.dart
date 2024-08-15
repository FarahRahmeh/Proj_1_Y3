import 'dart:convert';

import 'package:booktaste/common/features/challenges/genre_challenge_model.dart';
import 'package:booktaste/data/repositories/challenge_repository.dart';
import 'package:booktaste/models/book.dart';
import 'package:booktaste/utils/constans/api_constans.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'challenge_model.dart';
import 'package:http/http.dart' as http;

class ChallengeController extends GetxController {
  var challenges = <Challenge?>[].obs;
  var isLoading = true.obs;
  var bookDetails = Rxn<Book>();
  var genreDetails = Rxn<GenreChallenge>();

  @override
  void onInit() {
    fetchChallenges();
    super.onInit();
  }

  Future<List<Challenge?>> fetchChallenges() async {
    try {
      isLoading(true);
      var fetchedChallenges = await ChallengeRepository().fetchChallenges();
      if (fetchedChallenges != null) {
        challenges.value = fetchedChallenges;
      }
      return challenges.toList(); // Return the list of challenges
    } finally {
      isLoading(false);
    }
  }

  Future<void> openChallenge(Challenge challenge,
      {String? about, List<int>? booksArray}) async {
    final response = await ChallengeRepository().openChallenge(
      challenge.id.toString(),
      about: about,
      booksArray: booksArray,
    );

    if (response.statusCode == 200) {
      Get.snackbar('Success', 'Challenge opened successfully!');
    } else {
      Get.snackbar('Error', 'Failed to open challenge.');
    }
  }

  // Future<void> joinChallenge(String challengeId) async {
  //   final response = await http.post(
  //     Uri.parse('$baseUrl/join/$challengeId'),
  //     headers: {
  //       'Accept': 'application/json',
  //       'Content-Type': 'application/json',
  //       'Authorization': 'Bearer ${GetStorage().read('TOKEN')}',
  //       'Connection': 'keep-alive',
  //       'Accept-Encoding': 'gzip, deflate, br',
  //     },
  //   );

  //   if (response.statusCode == 200) {
  //     Get.snackbar('Success', 'Joined the challenge successfully!');
  //   } else {
  //     Get.snackbar('Error', 'Failed to join challenge.');
  //   }
  // }
  Future<void> joinChallenge(String challengeId) async {
    final response = await http.get(
      Uri.parse('$baseUrl/join/$challengeId'),
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${GetStorage().read('TOKEN')}',
        'Connection': 'keep-alive',
        'Accept-Encoding': 'gzip, deflate, br',
      },
    );

    if (response.statusCode == 200) {
      if (challengeId == '3') {
        bookDetails.value = Book.fromJson(json.decode(response.body));

        print(bookDetails);
        Get.snackbar(
            'Success', 'Joined book challenge: ${bookDetails.value!.name}!');
      } else if (challengeId == '2') {
        genreDetails.value =
            GenreChallenge.fromJson(json.decode(response.body));
        print(genreDetails);
        Get.snackbar(
            'Success', 'Joined cafe challenge: ${genreDetails.value!.genre}!');
      } else {
        // Handle general case
        Get.snackbar('Success', 'Challenge joined successfully!');
      }
    } else {
      print(jsonDecode(response.body));
      Get.snackbar('Error', 'Failed to join challenge.');
    }
  }

  Future<void> leaveChallenge(String challengeId) async {
    final response = await http.get(
      Uri.parse('$baseUrl/left/$challengeId'),
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${GetStorage().read('TOKEN')}',
        'Connection': 'keep-alive',
        'Accept-Encoding': 'gzip, deflate, br',
      },
    );

    if (response.statusCode == 200) {
      Get.snackbar('Success', 'Left the challenge successfully!');
    } else {
      Get.snackbar('Error', 'Failed to leave challenge.');
    }
  }

  void fetchChallengeDetails(int challengeId) {}
}
