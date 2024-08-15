
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../../../utils/constans/api_constans.dart';
import 'like_dislike_feedback_model.dart';

class LikeFeedbackRepositories extends GetxController{
  static Future<String> getLike(int bookid) async {
    final response = await http.get(
      Uri.parse('$baseUrl/like/like/$bookid'),
      headers: {
        'Accept': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      var like = response.body;
      print(like);
      return like;
    } else {
      return '';
    }
  }
}
class DisLikeFeedbackRepositories extends GetxController{
  static Future<String> getLike(int bookid) async {
    final response = await http.get(
      Uri.parse('$baseUrl/like/like/$bookid'),
      headers: {
        'Accept': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      var dislike = response.body;
      print(dislike);
      return dislike;
    } else {
      return '';
    }
  }
}