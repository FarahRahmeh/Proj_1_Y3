import 'package:booktaste/utils/constans/api_constans.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

import '../../common/features/challenges/challenge_model.dart';

class ChallengeRepository extends GetxController {
  var headers = {
    'Accept': 'application/json',
    'Content-Type': 'application/json',
    'Authorization': 'Bearer ${GetStorage().read('TOKEN')}',
    'Connection': 'keep-alive',
  };
  Future<List<Challenge?>?> fetchChallenges() async {
    final response =
        await http.get(Uri.parse('$baseUrl/allChallenges'), headers: headers);

    if (response.statusCode == 200) {
      return challengeFromJson(response.body);
    } else {
      print('challenge repo error' + response.statusCode.toString());
      return null;
    }
  }

  Future<http.Response> openChallenge(String id,
      {String? about, List<int>? booksArray}) async {
    final url = Uri.parse('$baseUrl/open/$id');

    final Map<String, dynamic> body = {};

    if (about != null) {
      body['about'] = about;
    }
    if (booksArray != null && booksArray.isNotEmpty) {
      for (int i = 0; i < booksArray.length; i++) {
        body['books_array[$i]'] = booksArray[i];
      }
    }

    final response = await http.post(
      url,
      body: body,
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer ${GetStorage().read('TOKEN')}',
        'Connection': 'keep-alive',
        'Accept-Encoding': 'gzip, deflate, br',
      },
    );

    return response;
  }
}
