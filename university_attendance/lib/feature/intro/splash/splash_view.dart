// feature/intro/splash/splash_view.dart
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:university_attendance/core/functions/navigation.dart';
import 'package:university_attendance/core/services/local_storage/local_storage.dart';
import 'package:university_attendance/feature/doctor/presentation/doctor_home_reg.dart';
import 'package:university_attendance/feature/intro/onboard/presentation/onboard_view.dart';
import 'package:university_attendance/feature/intro/welcome/presentation/welcome_view.dart';
import 'package:university_attendance/feature/patient/presentation/views/nav_bar/nav_bar_screen.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  User? user;
  getUser() async {
    user = FirebaseAuth.instance.currentUser;
  }

  @override
  void initState() {
    super.initState();
    getUser();
    Future.delayed(const Duration(seconds: 5), () {
      bool isOnboardingShown =
          AppLocalStorage.getCachedData(key: AppLocalStorage.onboarding) ??
              false;

      if (user != null) {
        //user is doctor or patient
        if (user?.photoURL == 'doctor') {
          pushReplacement(context, const DoctorHomeReg());
        } else if (user?.photoURL == 'patient') {
          pushReplacement(context, const NavBarScreen());
        }
      } else {
        if (isOnboardingShown) {
          pushReplacement(context, const WelcomeView());
        } else {
          pushReplacement(context, const OnboardView());
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFDDE4E3),
      body: Center(
        child: Image.asset(
          'assets/images/logo.png',
        ),
      ),
    );
  }
}
