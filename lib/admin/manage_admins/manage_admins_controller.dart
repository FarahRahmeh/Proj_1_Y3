import 'dart:convert';

import 'package:booktaste/admin/manage_admins/admin_model.dart';
import 'package:booktaste/admin/navigation/admin_navigation_menu.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data/repositories/auth_repository.dart';
import '../../utils/popups/loaders.dart';

class ManageAdminsController extends GetxController {
  //Variables
  final hidePassword = true.obs;
  final hidePasswordConfirmation = true.obs;
  var adminList = <Admin>[].obs;
  var isAdminsLoading = true.obs;

  //

  final name = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  final passwordConfirmation = TextEditingController();
  final _authRepository = Get.put(AuthRepository());
  GlobalKey<FormState> addAdminFormKey = GlobalKey<FormState>();

  @override
  void onInit() {
    fetchAdmins();
    super.onInit();
  }

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

      if (response.statusCode == 200) {
        //! These are important !!! it may cause anothe duplicated global key exception
        clearFormFields();
        addAdminFormKey = GlobalKey<FormState>();
        Get.to(() => const AdminNavigationMenu());
        final ctrl = Get.put(ManageAdminsController());
        ctrl.fetchAdmins();
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

  //! fetch Admins
  Future<void> fetchAdmins() async {
    try {
      isAdminsLoading.value = true;
      var response = await _authRepository.fetchAllAdmins();
      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body);
        List<Admin> admins = [];
        for (var admin in jsonData) {
          admins.add(Admin.fromJson(admin));
        }
        adminList.value = admins;
      } else {
        Loaders.errorSnackBar(title: 'Oops', message: 'Failed to fetch admins');
        print('Failed to fetch admins');
      }
    } catch (e) {
      isAdminsLoading(false);
      Loaders.errorSnackBar(title: 'On Snap', message: e.toString());
      print('Error occurred: $e');
    } finally {
      isAdminsLoading(false);
    }
  }

  //! Remove admin
  Future<void> removeAdmin(int id) async {
    try {
      var response = await _authRepository.removeAdmin(id);
      if (response.statusCode == 200) {
        final ctrl = Get.put(ManageAdminsController());
        ctrl.fetchAdmins();
        Loaders.successSnackBar(
            title: 'Success', message: 'Admin removed successfully');
      } else {
        Loaders.errorSnackBar(
            title: 'Error', message: 'Failed to remove admin');
      }
    } catch (e) {
      Loaders.errorSnackBar(title: 'On Snap', message: e.toString());
      print('Error occurred: $e');
    }
  }
}
