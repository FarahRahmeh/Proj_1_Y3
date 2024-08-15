import 'dart:convert';

import 'package:booktaste/user/user_profile/user_profile_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data/repositories/auth_repository.dart';
import '../../utils/popups/loaders.dart';

class ChangePasswordController extends GetxController {
  final oldPasswordController = TextEditingController();
  final newpassController = TextEditingController();
  final newpassConfirmController = TextEditingController();
  final hidePassword = true.obs;
  final hidePasswordConfirmation = true.obs;
  final hideOldPassword = true.obs;
  final _authRepository = Get.put(AuthRepository());

  GlobalKey<FormState> changePassKey = GlobalKey<FormState>();

  Future<void> changePassword() async {
    try {
      if (!changePassKey.currentState!.validate()) {
        return;
      }
      final response = await _authRepository.changePasswordByOldPassword(
          oldPasswordController.text.trim(),
          newpassController.text.trim(),
          newpassConfirmController.text.trim());
      print(response.body.toString());
      final userData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        Get.back();
        Loaders.successSnackBar(title: 'Success', message: userData);
      } else {
        final message = userData['message'];
        Loaders.errorSnackBar(title: 'faild: ', message: message);
      }
    } catch (e) {
      Loaders.errorSnackBar(title: 'On Snap', message: e.toString());
      print(e.toString());
    }
  }
}
