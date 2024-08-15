import 'package:booktaste/common/widgets/appbar/appbar.dart';
import 'package:booktaste/common/widgets/custom_shapes/Containers/stacked_with_image_container.dart';
import 'package:booktaste/common/widgets/icons/circular_icon.dart';
import 'package:booktaste/common/widgets/layouts/grid_layout.dart';
import 'package:booktaste/user/user_own_lists/approved_book_requests/approved_list_page.dart';
import 'package:booktaste/user/user_own_lists/favourite_list/favourite_list_page.dart';
import 'package:booktaste/user/user_own_lists/read_history_list/read_history_list_page.dart';
import 'package:booktaste/user/user_own_lists/read_later_list/read_later_list_page.dart';
import 'package:booktaste/user/user_own_lists/reading_list/reading_list_page.dart';
import 'package:booktaste/user/user_own_lists/user_unlocked_list/unlocked_list_view.dart';
import 'package:booktaste/utils/constans/sizes.dart';
import 'package:booktaste/utils/popups/loaders.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../../utils/constans/colors.dart';
import '../../utils/constans/images.dart';
import '../navigation/user_navigation_menu.dart';

class UserAllListsView extends StatelessWidget {
  UserAllListsView({
    super.key,
  });
  final List<String> lists = [
    'Tasty Reads',
    'Reading Journey',
    'On The Table',
    'Next On The Menu',
    'Revealed Books',
    'Greenlighted Gems',
  ];
  final List<Color> colors = [
    pinkish.withOpacity(0.6),
    lightBrown.withOpacity(0.8),
    bluish2,
    beige,
    beige2,
    gray,
  ];
  final List<String> images = [
    Images.fav,
    Images.history,
    Images.reading,
    Images.later,
    Images.approved,
    Images.unlocked,
  ];
  // final List<String> phrase = [
  //   'Books that stole your heart.',
  //   'Books you’ve finished reading.',
  //   'Books you’re currently exploring.',
  //   'Books that caught your fancy for later.',
  //   'Books you recommended and BookTaste approved.',
  //   'Books you’ve earned access to.',
  // ];
  final List<Function()?> onTapFun = [
    () => Get.to(() => FavouritePage()),
    () => Get.to(() => ReadHistoryPage()),
    () => Get.to(() => ReadingListPage()),
    () => Get.to(() => ReadLaterPage()),
    () => Get.to(() => ApprovedListPage()),
    () => Get.to(() => UnlockedListPage()),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.transparent,
      appBar: MyAppBar(
        title: Text(
          'My Nook',
          // style: Theme.of(context).textTheme.headlineMedium,
        ),
        actions: [
          CircularIcon(
            backgroundColor: Colors.transparent,
            icon: Iconsax.add_circle_copy,
            onPressed: () {
              final navigationController = Get.find<UserNavigationController>();
              navigationController.setSelectedIndex(0);
              Loaders.customToast(
                  message:
                      'Adding new book to your nook?📚\nHere where every book is a new taste to explore! ',
                  duration: Duration(milliseconds: 3000));
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(Sizes.defaultSpace),
          child: Column(
            children: [
              SizedBox(
                height: Sizes.md,
              ),
              // Column(
              //   children: [
              //     SizedBox(
              //!....................................................
              // height: 400,
              // child:
              MyGridLayout(
                mainAxisExtent: 220,
                itemCount: lists.length,
                itemBuilder: (_, index) => StackedWithImageContainer(
                  text: lists[index],
                  backgroundColor: colors[index],
                  height: 160,
                  onTap: onTapFun[index],
                  image: images[index],
                ),
              ),
              // ),
              // StackedWithImageContainer(),
              //   ],
              // )
            ],
          ),
        ),
      ),
    );
  }
}
