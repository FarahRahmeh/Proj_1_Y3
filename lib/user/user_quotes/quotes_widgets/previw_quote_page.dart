import 'dart:io';
import 'package:booktaste/common/widgets/appbar/appbar.dart';
import 'package:booktaste/common/widgets/custom_shapes/Containers/rounded_container.dart';
import 'package:booktaste/user/user_quotes/quote_model..dart';
import 'package:booktaste/utils/constans/colors.dart';
import 'package:booktaste/utils/constans/images.dart';
import 'package:booktaste/utils/constans/sizes.dart';
import 'package:booktaste/utils/helpers/helper_functions.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../../../utils/constans/api_constans.dart';
import 'add_new_quote_page.dart';

class QuotePreviewPage extends StatelessWidget {
  final Quote quote;

  QuotePreviewPage({Key? key, required this.quote}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dark = HelperFunctions.isDarkMode(context);
    String quoteText = '“${quote.quote}”\n\n'
        '-${quote.bookTitle} by ${quote.author}, ${quote.page}\n\n'
        '${quote.thoughts}\n\n'
        'Source ID: ${quote.sourceId}';
    final QuotePreviewController controller = Get.put(QuotePreviewController());

    return Scaffold(
      appBar: MyAppBar(
        title: SelectableText('Quote Preview'),
        showBackArrow: true,
        actions: [
          IconButton(
            icon: Icon(Iconsax.edit_2_copy),
            onPressed: () {
              Get.to(() => QuoteForm(quote: quote));
            },
          ),
          Obx(() {
            IconData alignmentIcon;
            switch (controller.textAlign.value) {
              case TextAlign.center:
                alignmentIcon = Iconsax.textalign_center;
                break;
              case TextAlign.right:
                alignmentIcon = Iconsax.textalign_right;
                break;
              case TextAlign.left:
              default:
                alignmentIcon = Iconsax.textalign_left;
            }
            return IconButton(
              icon: Icon(alignmentIcon),
              onPressed: () {
                controller.toggleTextAlign();
              },
            );
          }),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(Sizes.defaultSpace),
        child: SingleChildScrollView(
          child: RoundedContainer(
            backgroundColor: lightBrown.withOpacity(0.1),
            padding: EdgeInsets.all(Sizes.sm),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Obx(
                  () => SelectableText(
                    quoteText,
                    textAlign: controller.textAlign.value,
                  ),
                ),
                const SizedBox(height: Sizes.sm),
                quote.image == "/"
                    ? Container(
                        clipBehavior: Clip.none,
                        child: Image(
                          image: AssetImage(
                            Images.notesHand,
                          ),
                          fit: BoxFit.cover,
                        ),
                      )
                    : quote!.image.startsWith('/quotes')
                        ? CachedNetworkImage(
                            fit: BoxFit.cover,
                            imageUrl: '$baseImageUrl${quote.image}',
                            errorWidget: (context, url, error) {
                              print(quote.image);
                              return SizedBox(
                                child: Center(
                                    // child: Image(
                                    //   image: AssetImage(Images.quoteDefault),
                                    // ),
                                    ),
                              );
                            },
                            progressIndicatorBuilder:
                                (context, url, progress) => Center(
                              child: Icon(Iconsax.warning_2_copy),
                            ),
                          )
                        : Image.file(File(quote.image), fit: BoxFit.contain)
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class QuotePreviewController extends GetxController {
  var textAlign = TextAlign.left.obs;

  void toggleTextAlign() {
    if (textAlign.value == TextAlign.left) {
      textAlign.value = TextAlign.center;
    } else if (textAlign.value == TextAlign.center) {
      textAlign.value = TextAlign.right;
    } else {
      textAlign.value = TextAlign.left;
    }
  }
}
