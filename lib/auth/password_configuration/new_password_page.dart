import 'package:booktaste/auth/password_configuration/password_controller.dart';
import 'package:booktaste/common/widgets/appbar/appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../../common/widgets/images/rounded_image.dart';
import '../../utils/constans/colors.dart';
import '../../utils/constans/images.dart';
import '../../utils/constans/sizes.dart';
import '../../utils/validators/validation.dart';

class NewPasswordPage extends StatelessWidget {
  const NewPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ForgetPasswordController>();
    return Scaffold(
      appBar: const MyAppBar(
        title: Text('New Password'),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(Sizes.defaultSpace),
          child: Column(
            children: [
              const RoundedImage(
                imageUrl: Images.newPasword,
                width: double.infinity,
                height: 260,
              ),

              const SizedBox(
                height: Sizes.spaceBtwItems,
              ),
              //! Form
              Form(
                key: controller.newPasswordKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: controller.emailController,
                      validator: (value) => Validator.validateEmail(value),
                      decoration: InputDecoration(
                          hintText: ' exapmle@gmail.com',
                          hintStyle: TextStyle(color: gray),
                          labelText: 'Your Email Again',
                          prefixIcon: Icon(
                            Iconsax.sms_copy,
                            color: lightBrown,
                          )),
                    ),
                    SizedBox(
                      height: Sizes.spaceBtwInputFields,
                    ),

                    ///!Password
                    Obx(() => TextFormField(
                          controller: controller.passController,
                          decoration: InputDecoration(
                              labelText: 'New Password',
                              prefixIcon: const Icon(Iconsax.key),
                              suffixIcon: IconButton(
                                onPressed: () => controller.hidePassword.value =
                                    !controller.hidePassword.value,
                                icon: Icon(controller.hidePassword.value
                                    ? Iconsax.eye_slash
                                    : Iconsax.eye),
                              )),
                          obscureText: controller.hidePassword.value,
                          validator: (value) =>
                              Validator.validatePassword(value),
                        )),
                    const SizedBox(height: Sizes.spaceBtwInputFields),

                    ///!Password Comfirmation
                    Obx(() => TextFormField(
                          validator: (value) =>
                              Validator.validatePasswordConfirmation(
                                  controller.passController.text, value),
                          controller: controller.passConfirmController,
                          decoration: InputDecoration(
                              labelText: 'New Password Confirmation',
                              prefixIcon: const Icon(Iconsax.key),
                              suffixIcon: IconButton(
                                onPressed: () => controller
                                        .hidePasswordConfirmation.value =
                                    !controller.hidePasswordConfirmation.value,
                                icon: Icon(
                                    controller.hidePasswordConfirmation.value
                                        ? Iconsax.eye_slash
                                        : Iconsax.eye),
                              )),
                          obscureText:
                              controller.hidePasswordConfirmation.value,
                        )),

                    SizedBox(
                      height: Sizes.spaceBtwInputFields,
                    ),

                    ///submit button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          controller.newPassword();
                        },
                        child: const Text('Submit'),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
