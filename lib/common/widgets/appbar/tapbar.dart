import 'package:booktaste/utils/device/device_utility.dart';
import 'package:booktaste/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

import '../../../utils/constans/colors.dart';

class MyTapBar extends StatelessWidget implements PreferredSizeWidget {
//  You need to add the preferredSize widget to this screen to use them.
// If you want to keep [PreferredSize] widget that's created automatically in [PreferredSizeWidget].
  /// To do that you need the [PreferredSize] widget so that you have more class. More details at:
  /// [6](https://flutter.dev/docs/development/ui/widgets/layout)

  const MyTapBar({super.key, required this.tabs});
  final List<Widget> tabs;

  @override
  Widget build(BuildContext context) {
    final dark = HelperFunctions.isDarkMode(context);
    return Material(
      color: dark ? MyColors.black : Colors.white, //! Change here
      child: Container(
        width: double.infinity,
        child: Center(
          child: TabBar(
            overlayColor: MaterialStateColor.resolveWith(
                (states) => gray.withOpacity(0.4)),
            tabs: tabs,
            isScrollable: true,
            indicatorColor: dark ? lightBrown : darkBrown,
            labelColor: dark ? MyColors.white : darkBrown,
            unselectedLabelColor: MyColors.darkGrey,
          ),
        ),
      ),
    );
  }

  Size get preferredSize => Size.fromHeight(DeviceUtils.getAppBarHeight());
}
