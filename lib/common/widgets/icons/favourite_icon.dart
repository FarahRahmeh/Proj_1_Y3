import 'package:booktaste/models/book.dart';
import 'package:booktaste/utils/constans/colors.dart';
import 'package:booktaste/utils/constans/images.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../../../controllers/favourites/favourite_controller.dart';
import '../../../utils/helpers/helper_functions.dart';
import 'circular_icon.dart';
import '';

class FavouriteIcon extends StatelessWidget {
  const FavouriteIcon({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = HelperFunctions.isDarkMode(context);

    final Book book =
        Book(writer: 'writer', cover: Images.cover6, name: 'Book');

    // final FavController controller = Get.find<FavController>();
    final controller = Get.put(FavController());

    return Obx(() => CircularIcon(
          onPressed: () {
            if (controller.isFav(book)) {
              controller.removeFavFromList(book);
            } else {
              controller.addFavToList(book);
            }
          },
          backgroundColor:
              dark ? lightBrown.withOpacity(0.5) : beige2.withOpacity(0.7),
          icon: controller.isFav(book) ? Iconsax.heart : Iconsax.heart_copy,
          color: pinkishMore,
        ));
  }
}
