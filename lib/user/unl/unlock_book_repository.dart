import 'package:booktaste/user/unl/unlock_book_model.dart';
import 'package:booktaste/user/user_all_books/all_books_model.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

import '../../utils/constans/api_constans.dart';

class UnlockBookRepository extends GetxController {
  static Future<UnlockBook?> fechunlock(String bookid) async {
    final response = await http.get(
      Uri.parse('$baseUrl/unlock/${bookid}'),
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${GetStorage().read('TOKEN')}'
      },
    );
    if (response.statusCode == 200) {
      print(response.body);
      var unlock = response.body;
      return unlockFromJson(unlock);
    } else {
      print(response.statusCode);
      return null;
    }
  }
}
