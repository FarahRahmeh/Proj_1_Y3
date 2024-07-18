import 'dart:convert';

import 'package:booktaste/auth/code_confirmation/code_confirmation_page.dart';
import 'package:booktaste/auth/login/login_page.dart';
import 'package:booktaste/auth/register/register_page.dart';
import 'package:booktaste/utils/popups/loaders.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../data/repositories/auth_repository.dart';

class RegisterController extends GetxController {
  static RegisterController get instance => Get.find();

  ///Variables
  final hidePassword = true.obs;
  final hidePasswordConfirmation = true.obs;
  final email = TextEditingController();
  final userName = TextEditingController();
  final password = TextEditingController();
  final passwordConfirmation = TextEditingController();
  final codeController = TextEditingController();
  //  final List<TextEditingController> controllers = List.generate(5, (_) => TextEditingController());
  final localStorage = GetStorage();
  final _authRepository = Get.put(AuthRepository());

  GlobalKey<FormState> verifyKey = GlobalKey<FormState>();
  GlobalKey<FormState> codeKey = GlobalKey<FormState>();
  GlobalKey<FormState> registerFormKey = GlobalKey<FormState>();

  //! confirm code
  Future<void> confirmationCode() async {
    try {
      if (!codeKey.currentState!.validate()) {
        return;
      }

      final response = await _authRepository.codeConfirmation(
          email.text.trim(), codeController.text.trim());
      print(response.body.toString());

      final userData = jsonDecode(response.body); // to string

      if (response.statusCode == 200) {
        Loaders.successSnackBar(title: 'On Snap', message: userData);
        Get.to(() => const RegisterPage());
      } else {
        final message = userData['message'];
        //todo Need to change status code

        Loaders.errorSnackBar(title: 'faild: ', message: message);
      }
    } catch (e) {
      Loaders.errorSnackBar(title: 'On Snap', message: e.toString());
      print(e.toString());
    }
  }

//! Verify email
  Future<void> verifyEmail() async {
    try {
      if (!verifyKey.currentState!.validate()) {
        return;
      }
      final response = await _authRepository.verifyEmail(email.text.trim());
      print(response.body.toString());

      final userData = jsonDecode(response.body); // to string

      if (response.statusCode == 200) {
        Loaders.successSnackBar(title: 'On Snap', message: 'successfully');

        Get.to(() => const ConfirmationCodePage());
      } else {
        Loaders.errorSnackBar(title: 'faild: ', message: userData);
      }
    } catch (e) {
      Loaders.errorSnackBar(title: 'On Snap', message: e.toString());

      print(e.toString());
    }
  }

//! Register
  Future<void> register() async {
    try {
//       FullSCreenLoader.openLoadingDialog('We are processing your information...', TImages.docerAnimation);

// // Check Internet Connectivity
// final isConnected = await NetworkManager.instance.isConnected();

// if (!isConnected) {
//     FullScreenLoader.stopLoading();
//     return;
// }

      //Form Validation
      if (!registerFormKey.currentState!.validate()) {
        return;
      }

      final response = await _authRepository.register(
          userName.text.trim(),
          email.text.trim(),
          password.text.trim(),
          passwordConfirmation.text.trim());
      print(response.body.toString());

      final userData = json.decode(response.body); // to string
      if (response.statusCode == 200) {
        Get.offAll(() => const LoginPage());
      } else if (response.statusCode == 401)

      //!Wrong Password
      {
        //final message = userData['message'];

        //  Loaders.errorSnackBAr(title: 'login failed: ', message: userData);
      } else if (response.statusCode == 422) {
        // final message = userData['errors']['email'][0].toString();
        //final message = userData['message'];
        Loaders.errorSnackBar(
            title: 'register failed: ', message: response.body);
      } else {
        Loaders.errorSnackBar(title: 'Error', message: response.reasonPhrase);
        //throw 'Login failed: ${response.reasonPhrase}';
      }
    } catch (e) {
      Loaders.errorSnackBar(title: 'On Snap', message: e.toString());
      print(e.toString());
    }
  }
  // } catch (e) {
  //   Loaders.errorSnackBAr(title: 'On Snap', message: e.toString());
  // } finally {
  //   //FullScreenLoaders.stopLoading();
  // }
}
