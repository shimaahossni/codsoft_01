import 'dart:ui';
import 'package:flutter/painting.dart' show TextStyle;
import 'package:todo/core/utils/color.dart';

import '../constants/app_fonts.dart';


TextStyle gettitleTextStyle({double? fontsize,Color? color, FontWeight ? fontWeight}) {
  return TextStyle(
    fontFamily: AppFonts.poppins,
    fontSize: fontsize ?? 16,
    color: color ?? AppColor.purpleColor,
    fontWeight: fontWeight ?? FontWeight.bold,
  );
}