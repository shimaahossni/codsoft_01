// core/widgets/textfieldflorm_widget.dart
import 'package:flutter/material.dart';
import 'package:todo/core/utils/text_style.dart';

class TextfieldflormWidget extends StatelessWidget {
  TextfieldflormWidget(
      {super.key,
      this.hinttext,
      //this.prefixicon,
      this.labeltext,
      this.suffixIcon,
      this.isobsecure,
      this.validator,
      this.onChanged,
      this.controller,
      required this.onTap,
      this.keyboardType,
      this.maxLength,
      this.readOnly});

  final String? hinttext;
  final String? labeltext;
  Widget? suffixIcon;
  //final IconData? prefixicon;
  bool? isobsecure;
  String? Function(String?)? validator;
  ValueChanged<String>? onChanged;
  TextEditingController? controller;
  Function() onTap;
  TextInputType? keyboardType;
  int? maxLength;
  bool? readOnly;

  @override
  Widget build(BuildContext context) {
    Size mediaquery = MediaQuery.of(context).size;

    return TextFormField(
      readOnly: readOnly ?? false,
      maxLength: maxLength,
      obscureText: isobsecure!,
      validator: validator,
      onChanged: (value) => onChanged!(value),
      controller: controller,
      onTap: onTap,
      keyboardType: keyboardType,
      style: TextStyle(
        fontSize: mediaquery.height * 0.02,
      ),
      decoration: InputDecoration(
          hintText: hinttext,
          labelText: labeltext,
          hintStyle: gettitleTextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.w500,
              fontsize: mediaquery.height * 0.023),
          suffixIcon: suffixIcon,

          //prefixIcon: Icon(prefixicon),

          labelStyle:
              TextStyle(fontSize: mediaquery.height * 0.02, color: Colors.grey),
          border: const OutlineInputBorder(
            borderSide: BorderSide(
              width: 2,
              color: Color(0xff2f1440),
            ),
          ),
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            borderSide: BorderSide(
              color: Color(0xff2f1440),
            ),
          ),
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            borderSide: BorderSide(
              color: Color(0xff2f1440),
            ),
          ),
          hoverColor: Colors.grey.shade200,
          errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
          ),
          disabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            borderSide: BorderSide(
              color: Colors.red,
            ),
          ),
          errorStyle: TextStyle(
            fontSize: mediaquery.height * 0.017,
          )),
    );
  }
}
