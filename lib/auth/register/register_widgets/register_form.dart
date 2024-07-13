import 'package:booktaste/auth/register/register_controller.dart';
import 'package:booktaste/utils/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../../../utils/constans/sizes.dart';
import '../../../utils/constans/texts.dart';

class RegisterForm extends StatelessWidget {
  const RegisterForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<RegisterController>();
    return Form(
      key: controller.registerFormKey,
      child: Column(
        children: [
          ///! UserName

          TextFormField(
            controller: controller.userName,
            // expands: false,
            decoration: const InputDecoration(
              labelText: Texts.username,
              prefixIcon: Icon(Iconsax.user),
            ),
            validator: (value) =>
                Validator.validateEmptyText(value, 'User Name'),
          ),
          const SizedBox(height: Sizes.spaceBtwInputFields),

          ///!Email
          TextFormField(
            controller: controller.email,
            decoration: const InputDecoration(
              labelText: Texts.edtEmail,
              prefixIcon: Icon(Iconsax.sms),
            ),
            validator: (value) => Validator.validateEmail(value),
          ),
          const SizedBox(height: Sizes.spaceBtwInputFields),

          ///!Password
          Obx(() => TextFormField(
                controller: controller.password,
                decoration: InputDecoration(
                    labelText: Texts.password,
                    prefixIcon: const Icon(Iconsax.key),
                    suffixIcon: IconButton(
                      onPressed: () => controller.hidePassword.value =
                          !controller.hidePassword.value,
                      icon: Icon(controller.hidePassword.value
                          ? Iconsax.eye_slash
                          : Iconsax.eye),
                    )),
                obscureText: controller.hidePassword.value,
                validator: (value) => Validator.validatePassword(value),
              )),
          const SizedBox(height: Sizes.spaceBtwInputFields),

          ///!Password Comfirmation
          Obx(() => TextFormField(
                validator: (value) => Validator.validatePasswordConfirmation(
                    controller.password.text, value),
                controller: controller.passwordConfirmation,
                decoration: InputDecoration(
                    labelText: Texts.passwordComfiration,
                    prefixIcon: const Icon(Iconsax.key),
                    suffixIcon: IconButton(
                      onPressed: () => controller.hidePasswordConfirmation
                          .value = !controller.hidePasswordConfirmation.value,
                      icon: Icon(controller.hidePasswordConfirmation.value
                          ? Iconsax.eye_slash
                          : Iconsax.eye),
                    )),
                obscureText: controller.hidePasswordConfirmation.value,
              )),

          const SizedBox(height: Sizes.spaceBtwInputFields),

          ///
          ///
          ///!button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
                onPressed: () => controller.register(),
                child: const Text('Register')),
          ),
        ],
      ),
    );
  }
}
