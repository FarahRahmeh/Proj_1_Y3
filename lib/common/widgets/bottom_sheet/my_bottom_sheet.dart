import 'package:booktaste/utils/constans/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class MyBottomSheet extends StatelessWidget {
  const MyBottomSheet({
    super.key,
    this.title = 'Custom Bottom Sheet',
    this.child = const SizedBox.shrink(),
    this.height = 220,
  });
  final String title;
  final Widget child;
  final double height;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        height: height,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: Sizes.md),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(title, style: Theme.of(context).textTheme.headlineSmall),
                  IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: Icon(Icons.close),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: Sizes.spaceBtwItems / 2,
            ),
            child,
          ],
        ),
      ),
    );
  }
}
