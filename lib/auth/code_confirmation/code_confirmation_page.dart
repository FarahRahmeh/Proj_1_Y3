import 'package:booktaste/auth/code_confirmation/code_confirmation_and_verify_controller.dart';
import 'package:booktaste/auth/register/register_controller.dart';
import 'package:booktaste/common/widgets/appbar/appbar.dart';
import 'package:booktaste/utils/constans/colors.dart';
import 'package:booktaste/utils/constans/sizes.dart';
import 'package:booktaste/utils/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../../common/widgets/images/rounded_image.dart';
import '../../utils/constans/images.dart';

class ConfirmationCodePage extends StatelessWidget {
  const ConfirmationCodePage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<RegisterController>();
    List<FocusNode> focusNodes = List.generate(5, (_) => FocusNode());
    List<TextEditingController> controllers =
        List.generate(5, (_) => TextEditingController());

    return Scaffold(
      appBar: const MyAppBar(
        title: Text('Email Verification'),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: controller.codeKey,
          child: Padding(
            padding: const EdgeInsets.all(Sizes.defaultSpace),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const RoundedImage(
                  imageUrl: Images.codeConfirmation,
                  width: double.infinity,
                  height: 280,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: Sizes.xs),
                  child: Text(
                    "Enter verification code: ",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
                const SizedBox(
                  height: Sizes.spaceBtwInputFields,
                ),
                TextFormField(
                  controller: controller.codeController,
                  validator: (value) =>
                      Validator.validateCode(controller.codeController.text),
                  keyboardType: TextInputType.number,
                  maxLength: 5,
                  decoration: InputDecoration(
                      hintText: ' XXXXX',
                      hintStyle: TextStyle(color: gray),
                      labelText: 'Reset Code',
                      prefixIcon: Icon(
                        Iconsax.check_copy,
                        color: lightBrown,
                      )),
                ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                // children: List.generate(5, (i) {
                //   return SizedBox(
                //     width: 40,
                //     // height: 50,
                //     child: TextFormField(
                //         maxLength: 1,
                //         controller: controllers[i],
                //         keyboardType: TextInputType.number,
                //         textAlign: TextAlign.center,
                //         inputFormatters: [
                //           FilteringTextInputFormatter.digitsOnly,
                //           LengthLimitingTextInputFormatter(1),
                //         ],
                //         focusNode: focusNodes[i],
                //         onChanged: (value) {
                //           if (value.isNotEmpty) {
                //             if (i < 4) {
                //               FocusScope.of(context)
                //                   .requestFocus(focusNodes[i + 1]);
                //             }
                //           } else {
                //             if (i > 0) {
                //               FocusScope.of(context)
                //                   .requestFocus(focusNodes[i - 1]);
                //             }
                //           }
                //         }

                //         // validator: (value) => Validator.validateCode(value),
                //         ),
                //   );
                // }),
                //),
                const SizedBox(height: Sizes.spaceBtwInputFields / 2),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      //  String code = controllers.map((c) => c.text).join();
                      // controller.codeController.text = code;
                      await controller.confirmationCode();
                    },
                    child: const Text('Continue'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
