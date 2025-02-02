// feature/intro/splash_screen.dart
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:todo/core/services/app_local_storage.dart';
import 'package:todo/core/utils/text_style.dart';
import 'package:todo/feature/home/home_screen.dart';
import 'package:todo/feature/upload/upload_screen.dart';
import '../../core/functions/newNavigation.dart';
import '../../core/utils/color.dart';

class SplashScreen extends StatefulWidget {
  static const String routeApp = "/";
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    bool isUploaded =
        AppLocalStorage.getCachedData(AppLocalStorage.isUpload) ?? false;
    if (isUploaded) {
      Future.delayed(Duration(seconds: 3),
          () => pushWithReplacement(context, HomeScreen()));
    } else {
      Future.delayed(Duration(seconds: 3),
          () => pushWithReplacement(context, UploadScreen()));
    }
  }


  @override
  Widget build(BuildContext context) {
    Size mediaquery = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset('assets/images/logo.json'),
            Text(
              "Taskati",
              style:
                  gettitleTextStyle(fontsize: 24, color: AppColor.purpleColor),
            ),
            Text(
              "Your Personal Task Manager",
              style: gettitleTextStyle(color: AppColor.greyColor),
            ),
            SizedBox(
              height: mediaquery.height * .05,
            ),
            CircularProgressIndicator(
              color: AppColor.purpleColor,
            ),
          ],
        ),
      ),
    );
  }
}
