import 'package:booktaste/utils/constans/colors.dart';
import 'package:flutter/material.dart';

class MyTextButtonTheme {
  MyTextButtonTheme._(); //* to avoid creating instances
//! Light
  static final lightTextButtonTheme = TextButtonThemeData(
    style: TextButton.styleFrom(
      elevation: 0,
      foregroundColor: lightBrown,
      // backgroundColor: lightBrown,
      disabledForegroundColor: gray,
      // disabledBackgroundColor: gray,
      //  side: const BorderSide(color: lightBrown),
      //padding: const EdgeInsets.symmetric(vertical: 18),
      textStyle: const TextStyle(
          fontSize: 14, color: lightBrown, fontWeight: FontWeight.w500),
    ),
  );

//! Dark
  static final darkTextButtonTheme = TextButtonThemeData(
    style: TextButton.styleFrom(
      elevation: 0,
      foregroundColor: offWhite,
      // backgroundColor: lightBrown,
      disabledForegroundColor: gray,
      // disabledBackgroundColor: gray,
      // side: const BorderSide(color: lightBrown),
      //padding: const EdgeInsets.symmetric(vertical: 18),
      textStyle: const TextStyle(
          fontSize: 14, color: offWhite, fontWeight: FontWeight.w500),
    ),
  );
}
