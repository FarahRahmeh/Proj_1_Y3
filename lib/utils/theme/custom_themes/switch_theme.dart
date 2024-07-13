import 'package:flutter/material.dart';
import 'package:booktaste/utils/constans/colors.dart';

class MySwitchTheme {
  MySwitchTheme._(); //* to avoid creating instances

  static final lightSwitchTheme = SwitchThemeData(
    overlayColor: MaterialStateProperty.resolveWith<Color?>((states) {
      if (states.contains(MaterialState.pressed)) {
        return brown.withOpacity(0.54);
      }
      if (states.contains(MaterialState.hovered)) {
        return brown.withOpacity(0.04);
      }
      if (states.contains(MaterialState.focused)) {
        return brown.withOpacity(0.12);
      }
      return Colors.transparent;
    }),
    thumbColor: MaterialStateProperty.resolveWith<Color>((states) {
      if (states.contains(MaterialState.disabled)) {
        return gray;
      }
      return offWhite;
    }),
    trackColor: MaterialStateProperty.resolveWith<Color>((states) {
      if (states.contains(MaterialState.disabled)) {
        return gray.withOpacity(0.3);
      }
      return lightBrown;
    }),
    trackOutlineColor: MaterialStateProperty.resolveWith<Color?>((states) {
      if (states.contains(MaterialState.disabled)) {
        return Colors.transparent;
      }
      return offWhite;
    }),
  );

  static final darkSwitchTheme = SwitchThemeData(
    overlayColor: MaterialStateProperty.resolveWith<Color?>((states) {
      if (states.contains(MaterialState.pressed)) {
        return brown.withOpacity(0.54);
      }
      if (states.contains(MaterialState.hovered)) {
        return brown.withOpacity(0.04);
      }
      if (states.contains(MaterialState.focused)) {
        return brown.withOpacity(0.12);
      }
      return Colors.transparent;
    }),
    thumbColor: MaterialStateProperty.resolveWith<Color>((states) {
      if (states.contains(MaterialState.disabled)) {
        return gray;
      }
      return offWhite;
    }),
    trackColor: MaterialStateProperty.resolveWith<Color>((states) {
      if (states.contains(MaterialState.disabled)) {
        return gray.withOpacity(0.3);
      }
      return lightBrown;
    }),
    trackOutlineColor: MaterialStateProperty.resolveWith<Color?>((states) {
      if (states.contains(MaterialState.disabled)) {
        return Colors.transparent;
      }
      return offWhite;
    }),
  );
}
