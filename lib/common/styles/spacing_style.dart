import 'package:booktaste/utils/constans/sizes.dart';
import 'package:flutter/material.dart';

class MySpacingStyle {
  static const EdgeInsetsGeometry paddingWithAppBarHeight = EdgeInsets.only(
    top: Sizes.appBarHeight,
    left: Sizes.defaultSpace,
    bottom: Sizes.defaultSpace,
    right: Sizes.defaultSpace,
  );
}
