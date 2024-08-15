import 'package:booktaste/user/user_quotes/journal/journal_model.dart';
import 'package:booktaste/user/user_quotes/journal/journal_page.dart';
import 'package:booktaste/utils/constans/colors.dart';
import 'package:booktaste/utils/constans/images.dart';
import 'package:booktaste/utils/constans/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../utils/helpers/helper_functions.dart';

class JournalCard extends StatelessWidget {
  JournalCard(
      {super.key,
      this.width = 120,
      this.height = 160,
      this.image = Images.quotebook1,
      this.name = 'j1',
      required this.onDelete,
      // required this.onUpdate,
      required this.journal});
  final String image;
  final String name;
  final VoidCallback onDelete;
  final Journal journal;
  final double width, height;
  // final VoidCallback onUpdate;

  @override
  Widget build(BuildContext context) {
    final dark = HelperFunctions.isDarkMode(context);

    return GestureDetector(
      onTap: () => Get.to(() => JournalPage(journal: journal)),
      onLongPress: () {
        journal.name.toString() == 'general' ? () {} : onDelete();
      },
      child: Stack(
        alignment: Alignment.bottomLeft,
        children: [
          //! the face
          Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
              color: brown,
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(20.0),
                topRight: Radius.circular(20.0),
              ),
              border: Border.all(color: MyColors.darkestGrey),
              boxShadow: [
                BoxShadow(
                  color: dark
                      ? lightBrown.withOpacity(0.2)
                      : Colors.black.withOpacity(0.2), // Shadow color
                  offset: Offset(3, 4), // Shadow direction
                  blurRadius: 6.0, // Softness of the shadow
                  spreadRadius: 2.0, // How much the shadow spreads
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(20.0),
                topRight: Radius.circular(20.0),
              ),
              child: Image(
                image: AssetImage(
                    "assets/images/quoteBooks/${journal.imageName}.jpg"), ////////! fix here
                fit: BoxFit.cover,
              ),
            ),
          ),
          //! line
          Positioned(
            left: 5.5,
            child: Container(
              width: 3, // Thickness of the line
              height: height,
              color: MyColors.darkestGrey,
            ),
          ),
          //! Year
          Container(
            margin: EdgeInsets.symmetric(horizontal: Sizes.sm),
            padding: EdgeInsets.symmetric(horizontal: Sizes.xs / 2),
            decoration: BoxDecoration(
              border: Border.all(color: MyColors.darkestGrey),
              color: offWhite.withOpacity(0.8),
            ),
            child: Text(
              DateFormat.y().format(DateTime.now()),
              style: TextStyle(
                  color: MyColors.darkestGrey, fontSize: Sizes.fontSizeMd),
            ),
          ),
          // Positioned(
          //   right: 5,
          //   top: 5,
          //   child: IconButton(
          //     icon: Icon(Icons.delete, color: Colors.red),
          //     onPressed: onDelete, // Call the delete callback
          //   ),
          // ),
        ],
      ),
    );
  }
}
