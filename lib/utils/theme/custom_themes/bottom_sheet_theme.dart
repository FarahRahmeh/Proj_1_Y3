import 'package:booktaste/utils/constans/colors.dart';
import 'package:flutter/material.dart';

class MyBottomSheetTheme {
  MyBottomSheetTheme._();

  //! Light
  static BottomSheetThemeData lightBottomSheetTheme = BottomSheetThemeData(
    showDragHandle: true,
    backgroundColor: offWhite,
    modalBackgroundColor: offWhite,
    constraints: const BoxConstraints(minWidth: double.infinity),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
  );

  //! Dark
  static BottomSheetThemeData darkBottomSheetTheme = BottomSheetThemeData(
    showDragHandle: true,
    backgroundColor: lightBrown,
    modalBackgroundColor: lightBrown,
    constraints: const BoxConstraints(minWidth: double.infinity),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
  );
}
