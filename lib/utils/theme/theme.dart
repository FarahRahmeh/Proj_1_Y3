import 'package:booktaste/utils/theme/custom_themes/appbar_theme.dart';
import 'package:booktaste/utils/theme/custom_themes/bottom_sheet_theme.dart';
import 'package:booktaste/utils/theme/custom_themes/checkbox_theme.dart';
import 'package:booktaste/utils/theme/custom_themes/chip_theme.dart';
import 'package:booktaste/utils/theme/custom_themes/dialog_theme.dart';
import 'package:booktaste/utils/theme/custom_themes/elevated_button_theme.dart';
import 'package:booktaste/utils/theme/custom_themes/outlined_button_theme.dart';
import 'package:booktaste/utils/theme/custom_themes/radio_theme.dart';
import 'package:booktaste/utils/theme/custom_themes/switch_theme.dart';
import 'package:booktaste/utils/theme/custom_themes/text_button_theme.dart';
import 'package:booktaste/utils/theme/custom_themes/text_field_theme.dart';
import 'package:booktaste/utils/theme/custom_themes/text_theme.dart';
import 'package:booktaste/utils/constans/colors.dart';
import 'package:flutter/material.dart';

class MyAppTheme {
  MyAppTheme._();

  //! Light Theme
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,

    brightness: Brightness.light,
    primaryColor: lightBrown,
    scaffoldBackgroundColor: offWhite,
    textTheme: MyTextTheme.lightTextTheme,
    chipTheme: MyChipTheme.lightChipTheme,
    appBarTheme: MyAppBarTheme.lightAppBarTheme,
    checkboxTheme: MyCheckboxTheme.lightCheckboxTheme,
    bottomSheetTheme: MyBottomSheetTheme.lightBottomSheetTheme,
    elevatedButtonTheme: MyElevatedButtonTheme.lightElevatedButtonTheme,
    outlinedButtonTheme: MyOutlinedButtonTheme.lightOutlinedButtonTheme,
    inputDecorationTheme: MyTextFormFieldTheme.lightInputDecorationTheme,
    textButtonTheme: MyTextButtonTheme.lightTextButtonTheme,
    dialogTheme: MyDialogTheme.lightDialogTheme,
    switchTheme: MySwitchTheme.lightSwitchTheme,
    radioTheme: MyRadioTheme.lightRadioTheme,
    // cardColor: beige2,
    // fontFamily: 'Poppins',
  );

  //! Dark Theme
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    primaryColor: lightBrown,
    scaffoldBackgroundColor: MyColors.black,
    textTheme: MyTextTheme.darkTextTheme,
    chipTheme: MyChipTheme.darkChipTheme,
    appBarTheme: MyAppBarTheme.darkAppBarTheme,
    checkboxTheme: MyCheckboxTheme.darkCheckboxTheme,
    bottomSheetTheme: MyBottomSheetTheme.darkBottomSheetTheme,
    elevatedButtonTheme: MyElevatedButtonTheme.darkElevatedButtonTheme,
    outlinedButtonTheme: MyOutlinedButtonTheme.darkOutlinedButtonTheme,
    inputDecorationTheme: MyTextFormFieldTheme.darkInputDecorationTheme,
    textButtonTheme: MyTextButtonTheme.darkTextButtonTheme,
    dialogTheme: MyDialogTheme.darkDialogTheme,
    switchTheme: MySwitchTheme.darkSwitchTheme,
    radioTheme: MyRadioTheme.darkRadioTheme,
  );
}
