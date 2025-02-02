import 'package:flutter/material.dart';

import '../utils/color.dart';
class ColorContainer extends StatelessWidget {
   ColorContainer({
     required this.ischecked,
    required this.color,super.key});

  Color color;
  bool ischecked=true;

  @override
  Widget build(BuildContext context) {
    Size mediaquery=MediaQuery.of(context).size;
    return Container(
      height: mediaquery.height*.045,
      width: mediaquery.height*.045,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: color
      ),
      child: Icon(ischecked
        ? Icons.check
      : null,
        color: AppColor.whiteColor,),
    );
  }
}
