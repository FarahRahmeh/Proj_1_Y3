import 'package:flutter/material.dart';

const offWhite = Color(0xffFEFEFE);
const lightBrown = Color(0xffB19087);
const darkBrown = Color(0xff8F584E);
const brown = Color(0xFF5A332C);
const beige = Color(0xffFFEBDC);
const beige2 = Color(0xffF6E3E0);
const pinkish = Color(0xffE68888);
const pinkishMore = Color(0xffE27070);
const gray = Color(0xffD1C4C4);

const bluish = Color(0xff68749c);
const bluish2 = Color(0xffa5b0cc);
const bluish3 = Color(0xffcfdcff);

final List<Color> gradientColors = [
  offWhite,
  lightBrown,
  darkBrown,
  brown,
  beige,
  pinkish,
  gray,
];
final List<Color> colorList = [
  lightBrown.withOpacity(0.6),
  lightBrown.withOpacity(0.3),
  bluish3.withOpacity(0.8),
  bluish.withOpacity(0.9),
  // beige.withOpacity(0.7),
  // beige2.withOpacity(0.7),
  pinkish.withOpacity(0.7),
  bluish.withOpacity(0.5),
  gray.withOpacity(0.5),
  pinkish.withOpacity(0.3),
  lightBrown.withOpacity(0.2),
  bluish3.withOpacity(0.7),
  bluish2.withOpacity(0.7),
  beige.withOpacity(0.6),
  beige2.withOpacity(0.6),
  pinkish.withOpacity(0.5),
  pinkishMore.withOpacity(0.3),
  gray.withOpacity(0.5),
  beige2.withOpacity(0.5),
  lightBrown.withOpacity(0.7),
  bluish2.withOpacity(0.5),
  bluish.withOpacity(0.5),
  beige.withOpacity(0.3),
  beige2.withOpacity(0.4),
  pinkish.withOpacity(0.7),
  pinkishMore.withOpacity(0.1),
  gray.withOpacity(0.2),
  bluish3.withOpacity(0.6),
  bluish.withOpacity(0.9),
  bluish2.withOpacity(0.4),
  bluish.withOpacity(0.6),
  beige.withOpacity(0.4),
  beige2.withOpacity(0.3),
  pinkish.withOpacity(0.1),
  pinkishMore.withOpacity(0.4),
  bluish3.withOpacity(0.4),
];
final List<Gradient> gradients = [
  //~ white and light brown
  const LinearGradient(
    colors: [
      offWhite,
      lightBrown,
      lightBrown,
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    tileMode: TileMode.decal,
  ),
  //~ light and dark brown
  const LinearGradient(
    colors: [lightBrown, darkBrown],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  ),
  //~ dark brown and beige
  const LinearGradient(
    colors: [darkBrown, beige],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  ),
  //~ beige and peach
  const LinearGradient(
    colors: [beige, pinkish],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  ),
  //~ white and gray
  const LinearGradient(
    colors: [offWhite, MyColors.grey],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  ),
];

class MyColors {
  MyColors._();

  ///App Basic Colors
  static const Color primary = gray;
  static const Color secondary = pinkish;
  static const Color accent = lightBrown;

  ///Gradient Colors
  static const Gradient linerGradient = LinearGradient(
      begin: Alignment(0.0, 0.0),
      end: Alignment(0.707, -0.707),
      colors: [lightBrown, beige2, beige]);

  ///Text Colors
  static const Color textPrimary = brown;
  static const Color textSecondary = darkBrown;
  static const Color textWhite = offWhite;

  /// Background Colors
  static const Color light = offWhite;
  static const Color dark = Color(0xff212121);
  static const Color primaryBackground = offWhite;

  ///Background Container Colors
  static const Color lightContainer = Color(0xfff6f6f6);
  static Color darkContainer = offWhite.withOpacity(0.1);

  ///Button Colors
  static const Color buttonPrimary = darkBrown;
  static const Color buttonSecondary = lightBrown;
  static const Color buttonDisabled = gray;

  ///Border Colors
  static const Color borderPrimary = beige;
  static const Color borderSecondary = offWhite;

  ///Error and Validation Colors
  static const Color error = pinkishMore;
  static const Color success = Color.fromARGB(255, 165, 214, 167);
  static const Color warning = Color.fromARGB(255, 255, 224, 178);
  static const Color info = darkBrown;

  ///Neutral Shades
  static const Color black = Color(0xff212121);
  static const Color darkestGrey = Color.fromARGB(255, 59, 59, 59);
  static const Color darkGrey = Color.fromARGB(255, 113, 112, 112);
  static const Color grey = Color.fromARGB(255, 169, 169, 169);
  static const Color softGrey = Color.fromARGB(255, 217, 217, 217);
  static const Color lightGrey = Color.fromARGB(255, 235, 234, 234);
  static const Color white = Colors.white;
}
