import 'package:booktaste/admin/manage_admins/all_admins_page.dart';
import 'package:booktaste/admin/manage_admins/manage_admins_controller.dart';
import 'package:booktaste/common/widgets/appbar/appbar.dart';
import 'package:booktaste/utils/constans/colors.dart';
import 'package:booktaste/utils/constans/sizes.dart';
import 'package:booktaste/utils/constans/texts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../../common/widgets/images/rounded_image.dart';
import '../../utils/constans/images.dart';
import '../../utils/helpers/helper_functions.dart';
import '../../utils/validators/validation.dart';

class AddNewAdminPage extends StatelessWidget {
  const AddNewAdminPage({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = HelperFunctions.isDarkMode(context);
    final ManageAdminsController controller = Get.put(ManageAdminsController());

    return Scaffold(
      appBar: MyAppBar(
        title: Text(
          'Add New Admin',
        ),
        showBackArrow: true,
        actions: [
          IconButton(
            icon: Icon(Iconsax.people_copy),
            onPressed: () {
              Get.to(() => AllAdminsPage());
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(Sizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ///! Header: Image
              const RoundedImage(
                imageUrl: Images.newAdmin,
                width: double.infinity,
                height: 150,
              ),

              Padding(
                padding: const EdgeInsets.only(left: Sizes.xs),
                child: Text(
                  'Enter New Admin Details: ',
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .apply(color: dark ? offWhite : darkBrown),
                ),
              ),
              const SizedBox(
                height: Sizes.sm,
              ),

              ///!Form
              Form(
                key: controller.addAdminFormKey,
                child: Column(
                  children: [
                    ///! Admin Name
                    TextFormField(
                      controller: controller.name,
                      // expands: false,
                      decoration: const InputDecoration(
                        labelText: 'Name',
                        prefixIcon: Icon(Iconsax.security_user),
                      ),
                      validator: (value) =>
                          Validator.validateEmptyText(value, 'Name'),
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
                          validator: (value) =>
                              Validator.validatePassword(value),
                        )),
                    const SizedBox(height: Sizes.spaceBtwInputFields),

                    ///!Password Comfirmation
                    Obx(() => TextFormField(
                          validator: (value) =>
                              Validator.validatePasswordConfirmation(
                                  controller.password.text, value),
                          controller: controller.passwordConfirmation,
                          decoration: InputDecoration(
                              labelText: Texts.passwordComfiration,
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

                    const SizedBox(height: Sizes.spaceBtwInputFields),

                    ///
                    ///
                    ///!button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                          onPressed: () => controller.addNewAdmin(),
                          child: const Text('Save')),
                    ),
                  ],
                ),
              ),

              const SizedBox(
                height: Sizes.spaceBtwSections,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
