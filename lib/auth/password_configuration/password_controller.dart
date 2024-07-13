import 'dart:convert';

import 'package:booktaste/auth/login/login_page.dart';
import 'package:booktaste/auth/password_configuration/new_password_page.dart';
import 'package:booktaste/auth/password_configuration/reset_password_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../data/repositories/auth_repository.dart';
import '../../utils/popups/loaders.dart';

class ForgetPasswordController extends GetxController {
  final emailController = TextEditingController();
  final codeController = TextEditingController();
  final passController = TextEditingController();
  final passConfirmController = TextEditingController();

  final hidePassword = true.obs;
  final hidePasswordConfirmation = true.obs;

  final localStorage = GetStorage();
  final _authRepository = Get.put(AuthRepository());

  GlobalKey<FormState> verifyPassKey = GlobalKey<FormState>();
  GlobalKey<FormState> passCodeKey = GlobalKey<FormState>();
  GlobalKey<FormState> newPasswordKey = GlobalKey<FormState>();

  Future<void> passwordCode() async {
    try {
      if (!passCodeKey.currentState!.validate()) {
        return;
      }

      final response = await _authRepository.codeForgetPasswordConfirmation(
          emailController.text.trim(), codeController.text.trim());
      print(response.body.toString());

      final userData = jsonDecode(response.body); // to string

      if (response.statusCode == 200) {
        Loaders.successSnackBar(title: 'On Snap', message: userData);
        Get.to(() => const NewPasswordPage());
      } else {
        final message = userData['message'];
        //todo Need to change status code

        Loaders.errorSnackBAr(title: 'faild: ', message: message);
      }
    } catch (e) {
      Loaders.errorSnackBAr(title: 'On Snap', message: e.toString());
      print(e.toString());
    }
  }

  Future<void> passwordEmail() async {
    try {
      if (!verifyPassKey.currentState!.validate()) {
        return;
      }
      final response = await _authRepository
          .verifyForgetPasswordEmail(emailController.text.trim());

      print(response.body.toString());

      final userData = jsonDecode(response.body); // to string

      if (response.statusCode == 200) {
        Get.to(() => const ResetForgottenPasswordPage());
        Loaders.successSnackBar(title: 'On Snap', message: 'successfully');
      } else {
        Loaders.errorSnackBAr(title: 'faild: ', message: userData);
      }
    } catch (e) {
      Loaders.errorSnackBAr(title: 'On Snap', message: e.toString());

      print(e.toString());
    }
  }

  Future<void> newPassword() async {
    try {
      if (!newPasswordKey.currentState!.validate()) {
        return;
      }

      final response = await _authRepository.setNewPassword(
          emailController.text.trim(),
          passController.text.trim(),
          passConfirmController.text.trim());
      print(response.body.toString());

      final userData = jsonDecode(response.body); // to string

      if (response.statusCode == 200) {
        Loaders.successSnackBar(title: 'On Snap', message: userData);
        Get.offAll(() => const LoginPage());
      } else {
        final message = userData['message'];
        //todo Need to change status code

        Loaders.errorSnackBAr(title: 'faild: ', message: message);
      }
    } catch (e) {
      Loaders.errorSnackBAr(title: 'On Snap', message: e.toString());
      print(e.toString());
    }
  }
}
