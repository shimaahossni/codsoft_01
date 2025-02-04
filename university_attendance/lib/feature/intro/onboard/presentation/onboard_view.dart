// feature/intro/onboard/presentation/onboard_view.dart
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:university_attendance/core/functions/navigation.dart';
import 'package:university_attendance/core/services/local_storage/local_storage.dart';
import 'package:university_attendance/core/utils/colors.dart';
import 'package:university_attendance/core/utils/text_style.dart';
import 'package:university_attendance/core/widgets/custom_button.dart';
import 'package:university_attendance/feature/intro/onboard/data/model/onboard_model.dart';
import 'package:university_attendance/feature/intro/welcome/presentation/welcome_view.dart';

class OnboardView extends StatefulWidget {
  const OnboardView({super.key});

  @override
  State<OnboardView> createState() => _OnboardViewState();
}

class _OnboardViewState extends State<OnboardView> {
  var pageController = PageController();
  int currentPage = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        backgroundColor: AppColors.whiteColor,
        actions: [
          if (currentPage != pages.length - 1)
            TextButton(
              onPressed: () {
                AppLocalStorage.cacheData(
                    key: AppLocalStorage.onboarding, value: true);
                pushReplacement(context, const WelcomeView());
              },
              child: Text(
                'تخطي',
                style: getBodyStyle(
                  color: AppColors.blueColor,
                  fontSize: 20,
                ),
              ),
            ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(children: [
          // pageview
          Expanded(
              child: PageView.builder(
            controller: pageController,
            onPageChanged: (value) {
              setState(() {
                currentPage = value;
              });
            },
            itemBuilder: (context, index) {
              return Column(children: [
                // image
                const Spacer(),
                Image.asset(
                  pages[index].image,
                  //width: 300,
                ),
                const Spacer(),
                // title
                Text(
                  pages[index].title,
                  style: getTitleStyle(
                    color: AppColors.blueColor,
                    fontSize: 25,
                  ),
                ),
                const Gap(20),
                Text(
                  pages[index].body,
                  textAlign: TextAlign.center,
                  style: getBodyStyle(
                    fontSize: 20,
                  ),
                ),
                const Spacer(
                  flex: 3,
                ),
              ]);
            },
            itemCount: pages.length,
          )),
          // footer
          SizedBox(
            height: 70,
            child: Row(
              children: [
                SmoothPageIndicator(
                  controller: pageController,
                  count: pages.length,
                  effect: const SlideEffect(
                      spacing: 8.0,
                      radius: 15,
                      dotWidth: 24.0,
                      dotHeight: 13,
                      strokeWidth: 1.5,
                      dotColor: Colors.grey,
                      activeDotColor: AppColors.blueColor),
                ),
                const Spacer(),
                if (currentPage == pages.length - 1)
                  CustomButton(
                      height: 45,
                      text: 'هيا بنا',
                      onPressed: () {
                        AppLocalStorage.cacheData(
                            key: AppLocalStorage.onboarding, value: true);
                        pushReplacement(context, const WelcomeView());
                      },
                      width: 100)
              ],
            ),
          )
        ]),
      ),
    );
  }
}
