import 'package:booktaste/auth/password_configuration/password_controller.dart';
import 'package:booktaste/common/widgets/appbar/appbar.dart';
import 'package:booktaste/common/widgets/images/rounded_image.dart';
import 'package:booktaste/common/widgets/texts/section_heading.dart';
import 'package:booktaste/utils/constans/colors.dart';
import 'package:booktaste/utils/constans/images.dart';
import 'package:booktaste/utils/constans/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../../utils/validators/validation.dart';

class ForgetPasswordPage extends StatelessWidget {
  const ForgetPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ForgetPasswordController());

    return Scaffold(
      appBar: MyAppBar(
        title: Text('Forget Password'),
        showBackArrow: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(Sizes.defaultSpace),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RoundedImage(
                imageUrl: Images.forgotPassword,
                width: double.infinity,
                height: 300,
              ),
              Padding(
                padding: EdgeInsets.only(left: Sizes.xs, top: Sizes.sm),
                child: SectionHeading(
                  title: 'Enter Your Email : ',
                  showActionButton: false,
                ),
              ),
              SizedBox(
                height: Sizes.spaceBtwItems,
              ),
              //! Form
              Form(
                key: controller.verifyPassKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: controller.emailController,
                      validator: (value) => Validator.validateEmail(value),
                      decoration: InputDecoration(
                          hintText: ' exapmle@gmail.com',
                          hintStyle: TextStyle(color: gray),
                          labelText: 'Email',
                          prefixIcon: Icon(
                            Iconsax.sms_copy,
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
                          controller.passwordEmail();
                          //    Get.to(() => ResetForgottenPasswordPage());
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
