// core/widget/custom_button.dart
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  CustomButton(
      {super.key,
      this.bgcolor,
      this.textcolor,
      this.width,
      this.height,
      required this.text,
      required this.onPressed});

  Color? bgcolor;
  Color? textcolor;
  double? width;
  double? height;
  String text;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    Size mediaquery = MediaQuery.of(context).size;
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(
          horizontal: width ?? mediaquery.width * .2,
          vertical: height ?? mediaquery.height * .0125,
        ),
        backgroundColor: bgcolor ?? Colors.blue.shade700,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      // onPressed:(){},
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(
            color: textcolor ?? Colors.white, fontSize: mediaquery.width * .05),
      ),
    );
  }
}
