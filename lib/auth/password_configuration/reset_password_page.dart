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

class ResetForgottenPasswordPage extends StatelessWidget {
  const ResetForgottenPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ForgetPasswordController>();

    return Scaffold(
      appBar: const MyAppBar(
        title: Text('Reset Password Code'),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(Sizes.defaultSpace),
          child: Column(
            children: [
              const RoundedImage(
                imageUrl: Images.codeConfirmation,
                width: double.infinity,
                height: 260,
              ),

              const SizedBox(
                height: Sizes.spaceBtwItems,
              ),
              //! Form
              Form(
                key: controller.passCodeKey,
                child: Column(
                  children: [
                    ///! Email

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
                    //! Code
                    TextFormField(
                      controller: controller.codeController,
                      validator: (value) => Validator.validateCode(
                          controller.codeController.text),
                      keyboardType: TextInputType.number,
                      maxLength: 5,
                      decoration: InputDecoration(
                          hintText: ' XXXXX',
                          hintStyle: TextStyle(color: gray),
                          labelText: 'Reseet Code',
                          prefixIcon: Icon(
                            Iconsax.check_copy,
                            color: lightBrown,
                          )),
                    ),
                    SizedBox(
                      height: Sizes.spaceBtwInputFields,
                    ),

                    ///submit button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          controller.passwordCode();
                          //Get.to(() => NewPasswordPage());
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
