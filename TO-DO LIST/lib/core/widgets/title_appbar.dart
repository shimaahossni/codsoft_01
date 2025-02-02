// feature/home/widget/title_appbar.dart
import 'package:flutter/material.dart';
import 'package:todo/core/services/app_local_storage.dart';
import 'package:todo/core/utils/color.dart';
import 'package:todo/core/utils/text_style.dart';

class TitleAppBar extends StatelessWidget {
  const TitleAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    Size mediaquery = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              "Hello, ",
              style: gettitleTextStyle(fontsize: mediaquery.width * .052),
            ),
            Text(
              AppLocalStorage.getCachedData(AppLocalStorage.nameKey),
              style: gettitleTextStyle(fontsize: mediaquery.width * .052),
            ),
          ],
        ),
        Text(
          "Have A Nice Day. ",
          style: gettitleTextStyle(
              fontWeight: FontWeight.normal, color: AppColor.greyColor),
        ),
      ],
    );
  }
}
