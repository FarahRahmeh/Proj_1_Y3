//// Moved to register controller
// import 'dart:convert';

// import 'package:booktaste/auth/code_confirmation/code_confirmation_page.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get_storage/get_storage.dart';

// import '../../data/repositories/auth_repository.dart';
// import '../../utils/popups/loaders.dart';
// import '../register/register_page.dart';

// class ConfirmationController extends GetxController {
//   final emailController = TextEditingController();
//   final codeController = TextEditingController();
//   //  final List<TextEditingController> controllers = List.generate(5, (_) => TextEditingController());
   
  
//   final localStorage = GetStorage();
//   final _authRepository = Get.put(AuthRepository());
//   GlobalKey<FormState> verifyKey = GlobalKey<FormState>();
//   GlobalKey<FormState> codeKey = GlobalKey<FormState>();

//   Future<void> confirmationCode() async {
//     try {
//       if (!codeKey.currentState!.validate()) {
//         return;
//       }

//       final response = await _authRepository.codeConfirmation(
        
//           emailController.text.trim(), codeController.text.trim());
//       print(response.body.toString());

//       final userData = jsonDecode(response.body); // to string

//       if (response.statusCode == 200) {
//         Loaders.successSnackBar(title: 'On Snap', message: userData);
//         Get.to(() => const RegisterPage());
//       } else {
//         final message = userData['message'];
//         //todo Need to change status code

//         Loaders.errorSnackBAr(title: 'faild: ', message: message);
//       }
//     } catch (e) {
//       Loaders.errorSnackBAr(title: 'On Snap', message: e.toString());
//       print(e.toString());
//     }
//   }

//   Future<void> verifyEmail() async {
//     try {
//       if (!verifyKey.currentState!.validate()) {
//         return;
//       }
//       final response =
//           await _authRepository.verifyEmail(emailController.text.trim());
//       print(response.body.toString());

//       final userData = jsonDecode(response.body); // to string

//       if (response.statusCode == 200) {
//         Loaders.successSnackBar(title: 'On Snap', message: 'successfully');

//         Get.to(() => const ConfirmationCodePage());
//       } else {
//         Loaders.errorSnackBAr(title: 'faild: ', message: userData);
//       }
//     } catch (e) {
//       Loaders.errorSnackBAr(title: 'On Snap', message: e.toString());

//       print(e.toString());
//     }
//   }
// }
