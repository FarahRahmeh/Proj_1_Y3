import 'package:booktaste/utils/constans/colors.dart';
import 'package:flutter/material.dart';

class MyPopupMenuTheme {
  MyPopupMenuTheme._();

  static PopupMenuThemeData lightPopupMenuTheme = PopupMenuThemeData(
    color: gray,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
    elevation: 0,
    textStyle: TextStyle(
      color: brown,
      fontSize: 14,
      fontWeight: FontWeight.w800,
    ),
  );

  static PopupMenuThemeData darkPopupMenuTheme = PopupMenuThemeData(
    color: lightBrown,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
    elevation: 0,
    textStyle: TextStyle(
      color: offWhite,
      fontSize: 14,
      fontWeight: FontWeight.w800,
    ),
  );
}
