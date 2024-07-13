import 'package:booktaste/auth/register/register_widgets/register_form.dart';
import 'package:booktaste/common/widgets/appbar/appbar.dart';
import 'package:booktaste/common/widgets/divider/divider_with_text.dart';
import 'package:booktaste/utils/constans/colors.dart';
import 'package:booktaste/utils/constans/sizes.dart';
import 'package:booktaste/utils/constans/texts.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../../common/widgets/images/rounded_image.dart';
import '../../utils/constans/images.dart';
import '../../utils/helpers/helper_functions.dart';
import 'register_widgets/or_register_with.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = HelperFunctions.isDarkMode(context);

    return Scaffold(
      appBar: MyAppBar(
        title: Text('Register'),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(Sizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ///! Header: Image
              const RoundedImage(
                imageUrl: Images.register,
                width: double.infinity,
                height: 180,
              ),

              Padding(
                padding: const EdgeInsets.only(left: Sizes.xs),
                child: Text(
                  'Complete Sign Up : ',
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .apply(color: darkBrown),
                ),
              ),
              SizedBox(
                height: Sizes.sm,
              ),

              ///Form
              ///
              ///
              RegisterForm(),
              // SizedBox(
              //   height: 15,
              // ),

              //! commented because it is not working yet
              // DividerWithText(divderText: 'Or Sign Up with'),
              SizedBox(
                height: Sizes.spaceBtwSections,
              ),

              ///!Footer
              ///
              ///
              //RegisterWith(),
            ],
          ),
        ),
      ),
    );
  }
}
