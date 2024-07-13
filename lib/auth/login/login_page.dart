import 'package:booktaste/auth/password_configuration/new_password_page.dart';
import 'package:booktaste/common/widgets/appbar/appbar.dart';
import 'package:booktaste/common/widgets/divider/divider_with_text.dart';
import 'package:booktaste/utils/constans/images.dart';
import 'package:booktaste/utils/constans/sizes.dart';
import 'package:booktaste/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../common/widgets/images/rounded_image.dart';
import 'login_widgets/login_form.dart';
import 'login_widgets/or_login_with.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = HelperFunctions.isDarkMode(context);
    return Scaffold(
      appBar: const MyAppBar(title: Text('Login !')),
      body: SingleChildScrollView(
        ///!Header
        child: Padding(
          padding: const EdgeInsets.all(Sizes.defaultSpace),
          child: Column(
            children: [
              ///!Image
              RoundedImage(
                imageUrl: dark ? Images.heartbot : Images.onboarding_1,
                width: double.infinity,
                height: 220,
              ),

              const SizedBox(
                height: Sizes.spaceBtwItems,
              ),

              ///!Login Form
              const LoginForm(),
              const SizedBox(
                height: 10,
              ),

              // ///! Divider
              // const DividerWithText(divderText: 'Or Sign In With'),
              // const SizedBox(
              //   height: 15,
              // ),

              /////!Footer
              // OrLoginWith(),
            ],
          ),
        ),
      ),
    );
  }
}
