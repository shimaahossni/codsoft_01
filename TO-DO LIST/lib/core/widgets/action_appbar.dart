// core/widgets/action_appbar.dart
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:todo/core/functions/newNavigation.dart';
import 'package:todo/core/services/app_local_storage.dart';
import 'package:todo/core/utils/color.dart';
import 'package:todo/feature/profile/profile_screen.dart';

class ActionAppBar extends StatelessWidget {
  const ActionAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    Size mediaquery = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: AppColor.purpleColor),
      ),
      child: GestureDetector(
        onTap: () => pushTo(context, ProfileScreen()),
        child: CircleAvatar(
          radius: mediaquery.width * .08,
          backgroundImage: FileImage(File(
              AppLocalStorage.getCachedData(AppLocalStorage.imageKey) ?? "")),
        ),
      ),
    );
  }
}
