import 'dart:convert';

import 'package:booktaste/data/repositories/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../models/user_model.dart';
import '../../utils/popups/loaders.dart';
import '../../data/services/role.manager.dart';
import '../../data/services/token_manager.dart';

class LoginController extends GetxController {
  ///Variables
  final rememberMe = false.obs;
  final hidePassword = true.obs;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final localStorage = GetStorage();
  final _authRepository = Get.put(AuthRepository());
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  @override
  void onInit() {
    clearFormFields();

    emailController.text = localStorage.read('REMEMBER_ME_EMAIL') ?? '';
    passwordController.text = localStorage.read('REMEMBER_ME_PASSWORD') ?? '';
    super.onInit();
  }

  void clearFormFields() {
    emailController.clear();
    passwordController.clear();
  }

  Future<void> loginWithEmailAndPassword() async {
    try {
      if (!loginFormKey.currentState!.validate()) {
        return;
      }
      if (rememberMe.value) {
        localStorage.write('REMEMBER_ME_EMAIL', emailController.text.trim());
        localStorage.write(
            'REMEMBER_ME_PASSWORD', passwordController.text.trim());
      }

      final response = await _authRepository.login(
          emailController.text.trim(), passwordController.text.trim());
      //print(response.body.toString());

      final userData = json.decode(response.body); // to string
      if (response.statusCode == 200) {
        final token = userData['token'];
        final role = userData['user']['role'];

        await saveToken(token);
        final user = User(
            email: userData['user']['name'],
            role: userData['user']['role'],
            name: userData['user']['name']);
        // UserCredential(userRole: role);
        await saveRole(role);

        navigateBasedOnRole();

        print(token + ' ' + role);
      } else if (response.statusCode == 401) {
        ///!Wrong Password
        final message = userData['message'];
        Loaders.errorSnackBar(title: 'login failed: ', message: message);
      } else if (response.statusCode == 422) {
        final message = userData['message'];
        Loaders.errorSnackBar(title: 'login failed: ', message: message);
      } else {
        Loaders.errorSnackBar(title: 'Error', message: response.reasonPhrase);
      }
    } catch (e) {
      Loaders.errorSnackBar(title: 'On Snap', message: e.toString());
      print(e.toString());
    }
  }
}
