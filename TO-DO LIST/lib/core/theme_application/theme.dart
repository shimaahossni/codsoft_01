// core/theme_application/theme.dart
import 'package:flutter/material.dart';
import 'package:todo/core/utils/color.dart';

class ApplicationThemeManager {

  static const Color primaryColor = AppColor.purpleColor;

  /////////////////////////////////////////////////////////////////////////////light theme
  static ThemeData lightTheme = ThemeData(
    primaryColor: primaryColor,
    scaffoldBackgroundColor: AppColor.whiteColor,
    appBarTheme: AppBarTheme(
      color: AppColor.whiteColor,
    ),
  );

///////////////////////////////////////////////////////////////////////////dark theme
  static ThemeData darkTheme = ThemeData(
    primaryColor: primaryColor,
    scaffoldBackgroundColor: Color(0xFF919193),
    appBarTheme: AppBarTheme(
      color: Color(0xFF919193),
    ),
  );
}

