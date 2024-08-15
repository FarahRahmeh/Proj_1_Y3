import 'package:booktaste/auth/change_password/change_password_controller.dart';
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

class ChangePasswordPage extends StatelessWidget {
  const ChangePasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ChangePasswordController());
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
                key: controller.changePassKey,
                child: Column(
                  children: [
                    Obx(() => TextFormField(
                          controller: controller.oldPasswordController,
                          validator: (value) => Validator.validateEmptyText(
                              value, 'old password'),
                          decoration: InputDecoration(
                              hintText: 'old password',
                              hintStyle: TextStyle(color: gray),
                              labelText: 'Old password',
                              prefixIcon: Icon(
                                Iconsax.key_square,
                              ),
                              suffixIcon: IconButton(
                                onPressed: () => controller.hideOldPassword
                                    .value = !controller.hideOldPassword.value,
                                icon: Icon(controller.hideOldPassword.value
                                    ? Iconsax.eye_slash
                                    : Iconsax.eye),
                              )),
                          obscureText: controller.hideOldPassword.value,
                        )),
                    SizedBox(
                      height: Sizes.spaceBtwInputFields,
                    ),

                    ///!Password
                    Obx(() => TextFormField(
                          controller: controller.newpassController,
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
                                  controller.newpassController.text, value),
                          controller: controller.newpassConfirmController,
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
                          controller.changePassword();
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
