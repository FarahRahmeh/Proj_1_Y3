import 'package:booktaste/auth/login/login_controller.dart';
import 'package:booktaste/auth/password_configuration/forget_password_page.dart';
import 'package:booktaste/auth/verify_email/verify_email_page.dart';
import 'package:booktaste/user/navigation/user_navigation_menu.dart';
import 'package:booktaste/utils/constans/sizes.dart';
import 'package:booktaste/utils/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    controller.clearFormFields();

    return Form(
      key: controller.loginFormKey,
      child: Column(children: [
        ///!Email
        TextFormField(
          controller: controller.emailController,
          decoration: InputDecoration(
            prefixIcon: Icon(Iconsax.sms),
            labelText: "Email",
          ),
          validator: (value) => Validator.validateEmail(value),
        ),
        const SizedBox(
          height: Sizes.spaceBtwInputFields,
        ),

        ///!Password
        Obx(
          () => TextFormField(
            controller: controller.passwordController,
            decoration: InputDecoration(
              prefixIcon: const Icon(Iconsax.key),
              labelText: "Password",
              suffixIcon: IconButton(
                onPressed: () => controller.hidePassword.value =
                    !controller.hidePassword.value,
                icon: Icon(controller.hidePassword.value
                    ? Iconsax.eye_slash
                    : Iconsax.eye),
              ),
            ),
            validator: (value) =>
                // Validator.validateEmptyText(value, 'Password'),
                Validator.validatePassword(value),
            obscureText: controller.hidePassword.value,
          ),
        ),
        const SizedBox(
          height: Sizes.spaceBtwInputFields / 2,
        ),

        ///!Forget password & remember me
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Obx(
                  () => Checkbox(
                      value: controller.rememberMe.value,
                      onChanged: (value) => controller.rememberMe.value =
                          !controller.rememberMe.value),
                ),
                const Text('remember me'),
              ],
            ),
            TextButton(
              onPressed: () => Get.to(
                () => const ForgetPasswordPage(),
              ),
              child: const Text('Forget Password'),
            ),
          ],
        ),
        const SizedBox(
          height: Sizes.spaceBtwInputFields / 2,
        ),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
              onPressed: () async {
                controller.loginWithEmailAndPassword();
              },
              child:
                  // Obx(() {
                  // return controller.isLoading.value
                  //     ? const CircularProgressIndicator(
                  //         color: Colors.white,
                  //       )
                  const Text('Log In')),
        ),
        const SizedBox(
          height: 10,
        ),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton(
            onPressed: () => Get.to(
              () => const VerifyEmailPage(),
            ),
            child: const Text('Register'),
          ),
        )
      ]),
    );
  }
}
