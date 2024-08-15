import 'package:get_storage/get_storage.dart';

Future<String?> getUserId() async {
  final box = GetStorage();
  return box.read('USERID');
}

Future<void> saveUserId(String userId) async {
  final box = GetStorage();
  await box.write('USERID', userId);
}
