import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThemeController extends GetxController {
  var themeMode = ThemeMode.system.obs;
  final _debounceDuration = Duration(milliseconds: 500);
  DateTime? _lastToggleTime;

  void changeThemeMode(ThemeMode mode) {
    themeMode.value = mode;
    Get.changeThemeMode(mode);
  }

  void toggleTheme() {
    final now = DateTime.now();
    if (_lastToggleTime != null &&
        now.difference(_lastToggleTime!) < _debounceDuration) {
      return;
    }
    _lastToggleTime = now;

    if (themeMode.value == ThemeMode.dark) {
      changeThemeMode(ThemeMode.light);
    } else if (themeMode.value == ThemeMode.light) {
      changeThemeMode(ThemeMode.system);
    } else {
      changeThemeMode(ThemeMode.dark);
    }
  }
}
