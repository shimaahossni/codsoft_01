import 'package:flutter/material.dart';

import '../utils/color.dart';

ShowErrorDialog(BuildContext context,String text) {
  ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(text),backgroundColor: AppColor.purpleColor,)
  );
}