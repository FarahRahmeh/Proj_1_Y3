import 'package:flutter/material.dart';
import 'package:booktaste/utils/constans/colors.dart';

class MyRadioTheme {
  MyRadioTheme._(); //* to avoid creating instances

  //! Light
  static final lightRadioTheme = RadioThemeData(
    fillColor: MaterialStateProperty.resolveWith((states) {
      if (states.contains(MaterialState.disabled)) {
        return gray;
      }
      return lightBrown;
    }),
    overlayColor: MaterialStateProperty.resolveWith((states) {
      if (states.contains(MaterialState.hovered) ||
          states.contains(MaterialState.focused) ||
          states.contains(MaterialState.pressed)) {
        return lightBrown.withOpacity(0.12);
      }
      return Colors.transparent;
    }),
    splashRadius: 24,
    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
  );

  //! Dark
  static final darkRadioTheme = RadioThemeData(
    fillColor: MaterialStateProperty.resolveWith((states) {
      if (states.contains(MaterialState.disabled)) {
        return gray;
      }
      return offWhite;
    }),
    overlayColor: MaterialStateProperty.resolveWith((states) {
      if (states.contains(MaterialState.hovered) ||
          states.contains(MaterialState.focused) ||
          states.contains(MaterialState.pressed)) {
        return offWhite.withOpacity(0.12);
      }
      return Colors.transparent;
    }),
    splashRadius: 24,
    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
  );
}
