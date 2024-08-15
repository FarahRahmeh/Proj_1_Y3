import 'dart:convert';
import 'package:booktaste/data/services/token_manager.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

import '../../models/user_model.dart';
import '../../utils/constans/api_constans.dart';

class AuthRepository extends GetxController {
  ///static AuthRepository get instance => Get.find();

  ///Variables
  final deviceStorage = GetStorage();
  // final Rxn<User> _user = Rxn<User>();
  // User? get currentUser => _user.value;

  // This function will be called when the app launches
  // @override
  // void onReady() {
  //   super.onReady();
  //   screenRedirect();
  // }

  // void screenRedirect() async {
  //   final user = _authService.currentUser;
  //   if (user != null) {

  //     //todo Token not null
  //   // If the user's email is verified, navigate to the main navigation
  //   if (user.emailVerified) {
  //await LocalStorage.init(user.id);
  //     Get.offAll(() => const MainNavigation());
  //   } else {
  //     // If the user's email is not verified, navigate to VerifyEmailScreen
  //     Get.offAll(() => const VerifyEmailScreen());
  //   }
  //   } else {
  //   //   // Local Storage
  //
//deviceStorage.writeIfNull('IsFirstTime',true);
  //     // Check if it's the first time launching the app
  //     deviceStorage.read('IsFirstTime')!= true ? Get.offAll(login): Get.offAll onboading
  //       // Onboarding Screen
  //
  //   }
  // }

  // Determine the relevant screen and redirect accordingly
  // void screenRedirect() async {
  //   try {
  //     final url = Uri.parse('http://your-server-domain.com/api/check-auth');
  //     final response = await http.get(url);

  //     if (response.statusCode == 200) {
  //       // User is authenticated
  //       final userData = json.decode(response.body);
  //       final bool emailVerified = userData['emailVerified'] ?? false;

  //       if (emailVerified) {
  //         //Get.offAll(() => const NavigationMenu());
  //       } else {
  //         // Get.offAll(() => VerifyEmailPage(email: userData['email']));
  //       }
  //     } else {
  //       // User is not authenticated or token expired
  //       final bool isFirstTime = await checkFirstTimeLaunch();

  //       if (!isFirstTime) {
  //         Get.offAll(const LoginPage());
  //       } else {
  //         Get.offAll(const OnBoardingPages());
  //       }
  //     }
  //   } catch (e) {
  //     // Handle any exceptions that occur during the redirection process
  //     print('Error during redirection: $e');
  //   }
  // }

  // Check if it's the first time launching the app
  // Future<bool> checkFirstTimeLaunch() async {
  //   final box = GetStorage();

  //   bool isFirstTime = box.read('isFirstTime') ?? true;

  //   if (isFirstTime) {
  //     box.write('isFirstTime', false);
  //   }

  //   return isFirstTime;
  // }

  ///! [EmailAuthentication] - LOGIN
  Future<http.Response> login(String email, String password) async {
    final body = jsonEncode({'email': email, 'password': password, 'device_token': 'aaaaaaaa'});
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      body: body,
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json'
      },
    );

    return response;
  }

  ///! [EmailAuthentication] - REGISTER
  Future<http.Response> register(String name, String email, String password,
      String passwordConfirmation) async {
    final body = jsonEncode({
      'name': name,
      'email': email,
      'password': password,
      'password_confirmation': passwordConfirmation
    });
    final response = await http.post(
      Uri.parse('$baseUrl/register'),
      body: body,
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json'
      },
    );

    return response;
  }

  ///! [EmailAuthentication] - Code Confirmation
  Future<http.Response> codeConfirmation(String email, String code) async {
    final body = jsonEncode({'email': email, 'code': code});
    final response = await http.post(
      Uri.parse('$baseUrl/checkVerify'),
      body: body,
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json'
      },
    );

    return response;
  }

  ///! [EmailAuthentication] - Email verify
  Future<http.Response> verifyEmail(String email) async {
    final body = jsonEncode({'email': email});
    final response = await http.post(
      Uri.parse('$baseUrl/verifyCode'),
      body: body,
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json'
      },
    );

    return response;
  }

  ///! Forget Password Email verify
  Future<http.Response> verifyForgetPasswordEmail(String email) async {
    final body = jsonEncode({'email': email});
    final response = await http.post(
      Uri.parse('$baseUrl/forgotCode'),
      body: body,
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json'
      },
    );

    return response;
  }

  ///! Forget Password Code confirmation
  Future<http.Response> codeForgetPasswordConfirmation(
      String email, String code) async {
    final body = jsonEncode({'email': email, 'code': code});
    final response = await http.post(
      Uri.parse('$baseUrl/checkReset'),
      body: body,
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json'
      },
    );

    return response;
  }

  //! Set New Password
  Future<http.Response> setNewPassword(
      String email, String newPass, String confirmNewPass) async {
    final body = jsonEncode({
      'email': email,
      'new_password': newPass,
      'new_password_confirmation': confirmNewPass
    });
    final response = await http.post(
      Uri.parse('$baseUrl/newPass'),
      body: body,
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json'
      },
    );

    return response;
  }

  //! Add New Admin
  Future<http.Response> newAdmin(String name, String email, String password,
      String passwordConfirmation) async {
    final body = jsonEncode({
      'name': name,
      'email': email,
      'password': password,
      'password_confirmation': passwordConfirmation
    });
    final response = await http.post(
      Uri.parse('$baseUrl/addAdmin'),
      body: body,
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${GetStorage().read('TOKEN')}',
      },
    );

    return response;
  }
}
