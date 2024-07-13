import 'package:booktaste/common/widgets/icons/theme_switcher_icon.dart';
import 'package:booktaste/user/user_setting/user_setting_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common/widgets/appbar/appbar.dart';
import '../../../common/widgets/notification/notification_counter_icon.dart';
import '../../../utils/constans/colors.dart';
import '../../../utils/constans/texts.dart';

class AdminHomePageAppbar extends StatelessWidget {
  const AdminHomePageAppbar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MyAppBar(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Hello, Admin!',
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .apply(color: MyColors.lightGrey),
          ),
          Text(
            'Let`s Spice Things Up at BookTaste💼',
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .apply(color: MyColors.white),
          ),
        ],
      ),
      actions: [
        ThemeSwitcherIcon(),
        NotificationCounterIcon(
          onPressed: () {},
          iconColor: brown,
        ),
      ],
    );
  }
}
