import 'dart:convert';

import 'package:booktaste/admin/home/admin_home_page.dart';
import 'package:booktaste/admin/navigation/admin_navigation_menu.dart';
import 'package:booktaste/admin/settings/admin_setting_page.dart';
import 'package:booktaste/data/services/token_manager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../data/repositories/auth_repository.dart';
import '../../utils/popups/loaders.dart';

class ManageAdminsController extends GetxController {
  //Variables
  final hidePassword = true.obs;
  final hidePasswordConfirmation = true.obs;

  final name = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  final passwordConfirmation = TextEditingController();
  final _authRepository = Get.put(AuthRepository());
  GlobalKey<FormState> addAdminFormKey = GlobalKey<FormState>();

  void clearFormFields() {
    name.clear();
    email.clear();
    password.clear();
    passwordConfirmation.clear();
  }

  Future<void> addNewAdmin() async {
    try {
      //Form Validation
      if (!addAdminFormKey.currentState!.validate()) {
        return;
      }

      final response = await _authRepository.newAdmin(
          name.text.trim(),
          email.text.trim(),
          password.text.trim(),
          passwordConfirmation.text.trim());

      print(response.body.toString());
      // print();

      final userData = json.decode(response.body); // to string
      if (response.statusCode == 200) {
        //! These are important !!! it may cause anothe duplicated global key exception
        clearFormFields();
        addAdminFormKey = GlobalKey<FormState>();
        Get.to(() => const AdminNavigationMenu());
        Loaders.successSnackBar(
            title: 'Adding New Admin ', message: response.body);
      } else if (response.statusCode == 401) {
        // final message = userData['errors']['email'][0].toString();
        //final message = userData['message'];
        Loaders.errorSnackBar(title: 'failed: ', message: response.body);
      } else {
        //!handle backend if admin already in
        Loaders.errorSnackBar(title: 'Error', message: response.reasonPhrase);
        //throw 'Login failed: ${response.reasonPhrase}';
      }
    } catch (e) {
      Loaders.errorSnackBar(title: 'On Snap', message: e.toString());
      print(e.toString());
    }
  }
}
