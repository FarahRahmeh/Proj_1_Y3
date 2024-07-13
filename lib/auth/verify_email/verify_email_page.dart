import 'package:booktaste/auth/code_confirmation/code_confirmation_page.dart';
import 'package:booktaste/auth/login/login_page.dart';
import 'package:booktaste/auth/register/register_controller.dart';
import 'package:booktaste/common/widgets/appbar/appbar.dart';
import 'package:booktaste/common/widgets/images/rounded_image.dart';
import 'package:booktaste/utils/constans/sizes.dart';
import 'package:booktaste/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../../utils/constans/colors.dart';
import '../../utils/constans/images.dart';
import '../../utils/validators/validation.dart';
import '../code_confirmation/code_confirmation_and_verify_controller.dart';

class VerifyEmailPage extends StatelessWidget {
  const VerifyEmailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(RegisterController());
    final dark = HelperFunctions.isDarkMode(context);

    return Scaffold(
      appBar: MyAppBar(
        showBackArrow: true,
        title: Text('Verify Email Page'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(Sizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RoundedImage(
                imageUrl:
                    dark ? Images.emailVerifyDark : Images.emailVerifyLight,
                width: double.infinity,
                height: 240,
              ),
              const SizedBox(
                height: Sizes.spaceBtwItems,
              ),
              Padding(
                padding: const EdgeInsets.only(left: Sizes.xs),
                child: Text(
                  'Enter your Email: ',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
              const SizedBox(
                height: Sizes.spaceBtwItems,
              ),
              Form(
                key: controller.verifyKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: controller.email,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Iconsax.sms),
                        labelText: "Email",
                      ),
                      validator: (value) => Validator.validateEmail(value),
                    ),
                    const SizedBox(height: Sizes.spaceBtwSections / 2),
                    const Divider(
                      thickness: 1,
                      color: gray,
                    ),
                    const SizedBox(height: Sizes.spaceBtwSections / 2),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                          onPressed: () async {
                            controller.verifyEmail();
                          },
                          child: Text('Continue')),
                    ),
                    const SizedBox(
                      height: Sizes.spaceBtwInputFields / 1.5,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                          onPressed: () {
                            controller.verifyEmail();
                          },
                          child: const Text('Resend Email')),
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
