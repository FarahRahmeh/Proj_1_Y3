import 'package:booktaste/common/features/const_Images/const_images_controller.dart';
import 'package:booktaste/utils/constans/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../../../admin/manage_books/add_book/cover_preview_page.dart';

class ConstImageView extends StatelessWidget {
  const ConstImageView({
    super.key,
    //  this.onTap,
    required this.image,
    this.isSelected = false,
  });

  //final void Function()? onTap;
  final String image;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    final imgCtrl = Get.find<ConstImagesController>();

    return GestureDetector(
      onTap: () {
        print('seleted  $image');
        imgCtrl.selectImage(image);
      },
      onLongPress: () {
        Get.to(() => CoverPreviewPage(
              imagePath: image,
              isAsset: true,
            ));
      },
      child: Obx(() => Stack(
            alignment: Alignment.topRight,
            children: [
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(image),
                    fit: BoxFit.cover,
                    colorFilter: imgCtrl.isSelected(image)
                        ? ColorFilter.mode(
                            Colors.black.withOpacity(0.5), BlendMode.darken)
                        : null,
                  ),
                ),
              ),
              if (imgCtrl.isSelected(image))
                Container(
                  width: 100,
                  height: 100,
                  color: MyColors.black.withOpacity(0.2),
                ),
              Positioned(
                top: 4,
                right: 8,
                child: Icon(
                  imgCtrl.isSelected(image) ? Iconsax.tick_circle : null,
                  color: MyColors.success,
                  size: 25,
                ),
              ),
            ],
          )),
    );
  }
}
