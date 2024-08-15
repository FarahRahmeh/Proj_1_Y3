import 'dart:math';
import 'package:booktaste/admin/manage_books/add_book/add_new_book_page.dart';
import 'package:booktaste/utils/constans/colors.dart';
import 'package:booktaste/utils/constans/images.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class LibraryCard extends StatelessWidget {
  final String? cardNumber;
  final String imagePath;
  final bool isAdmin;

  const LibraryCard({
    Key? key,
    this.cardNumber,
    required this.imagePath,
    required this.isAdmin,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final readerPhrases = [
      'Request Your Favorite Book!',
      "Need Something New? Request It!",
      "Your Next Read, Just a Request Away!",
      "The Book You Need, Just a Click Away!",
      "Can't Find It? Request It!",
    ];

    final adminPhrases = [
      'Expand Our Library!',
      'Build the Library of Tomorrow!',
      'Add a Gem to Our Library!',
      'Help Us Grow!',
      'Curate the Best for Our Readers!',
    ];

    final phrase = isAdmin
        ? adminPhrases[Random().nextInt(adminPhrases.length)]
        : readerPhrases[Random().nextInt(readerPhrases.length)];

    return GestureDetector(
      onTap: () {
        Get.to(() => AddNewBookPage());
      },
      child: Container(
        height: 110,
        padding: const EdgeInsets.all(8.0),
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        decoration: BoxDecoration(
          color: beige2,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4.0,
              offset: Offset(2, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            // Image Section
            Container(
              width: 80,
              height: 80,
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
              ),
              child: Image.asset(
                Images.librarycard,
              ),
            ),
            const SizedBox(width: 16),

            // Text Section
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 8),

                Text(
                  ' BOOKTASTE CARD',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: darkBrown,
                  ),
                ),
                // const SizedBox(height: 8),
                // Text(
                //   cardNumber,
                //   style: const TextStyle(
                //     fontSize: 16,
                //     fontFamily: 'Courier',
                //   ),
                // ),

                const SizedBox(height: 8),
                Text(
                  phrase,
                  style: TextStyle(
                    fontSize: 12,
                    color: darkBrown,
                  ),
                ),
                const SizedBox(height: 8),
                Icon(
                  Iconsax.arrow_right_1_copy,
                  color: lightBrown,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
