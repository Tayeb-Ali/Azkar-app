import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'themes.dart';
import 'themes_enum.dart';

class ThemeServices {
  ///
  static final box = GetStorage();
  static const storeKey = "appThemeMode";

  /// Get appMode from storage
  static AppThemeMode? get appThemeMode {
    final stringVal = box.read<String>(storeKey) ??
        EnumToString.convertToString(AppThemeMode.dark);
    return EnumToString.fromString(AppThemeMode.values, stringVal);
  }

  /// Save Changes to storage
  static void changeAppThemeModeStatus(AppThemeMode? val) {
    final stringfyVal = EnumToString.convertToString(val);
    box.write(storeKey, stringfyVal);
    // box.write(storeKey, val);
  }

  /// Get AppTheme and change themes depend on its values
  static void handleThemeChange(AppThemeMode? val) {
    try {
      changeAppThemeModeStatus(val);
      if (val == AppThemeMode.light) {
        Get.changeTheme(Themes.light);
      } else if (val == AppThemeMode.dark) {
        Get.changeTheme(Themes.dark);
      } else if (val == AppThemeMode.defaultDark) {
        Get.changeTheme(Themes.darkDefault);
      } else if (val == AppThemeMode.yellowTheme) {
        Get.changeTheme(Themes.yellowTheme);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  /// Check if current theme is dark
  static bool isDarkMode() {
    if (appThemeMode == AppThemeMode.dark ||
        appThemeMode == AppThemeMode.defaultDark) {
      return true;
    } else {
      return false;
    }
  }

  /// toggle all themes
  static changeThemeMode() {
    if (appThemeMode == AppThemeMode.yellowTheme) {
      handleThemeChange(AppThemeMode.dark);
    } else if (appThemeMode == AppThemeMode.dark) {
      handleThemeChange(AppThemeMode.defaultDark);
    } else if (appThemeMode == AppThemeMode.defaultDark) {
      handleThemeChange(AppThemeMode.light);
    } else if (appThemeMode == AppThemeMode.light) {
      handleThemeChange(AppThemeMode.yellowTheme);
    }
  }

  /// Get appMode
  static ThemeData? getTheme() {
    if (appThemeMode == AppThemeMode.light) {
      return Themes.light;
    } else if (appThemeMode == AppThemeMode.dark) {
      return Themes.dark;
    } else if (appThemeMode == AppThemeMode.defaultDark) {
      return Themes.darkDefault;
    } else if (appThemeMode == AppThemeMode.yellowTheme) {
      return Themes.yellowTheme;
    } else {
      return Themes.dark;
    }
  }
}
