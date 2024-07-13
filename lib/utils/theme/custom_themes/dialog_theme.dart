import 'package:booktaste/utils/constans/colors.dart';
import 'package:flutter/material.dart';

class MyDialogTheme {
  MyDialogTheme._(); //* to avoid creating instances
//! Light
  static final lightDialogTheme = DialogTheme(
    backgroundColor: gray,
    elevation: 0,
    shadowColor: gray,
  );

//! Dark
  static final darkDialogTheme = DialogTheme(
    backgroundColor: lightBrown,
    elevation: 0,
    shadowColor: gray,
  );
}
