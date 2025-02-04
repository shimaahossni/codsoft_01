// feature/doctor/presentation/profile/page/user_setting.dart
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:university_attendance/core/functions/navigation.dart';
import 'package:university_attendance/core/utils/colors.dart';
import 'package:university_attendance/core/utils/text_style.dart';
import 'package:university_attendance/core/widgets/settings_tile.dart';
import 'package:university_attendance/feature/doctor/presentation/profile/page/new_password_doctor.dart';
import 'package:university_attendance/feature/doctor/presentation/profile/page/user_details.dart';
import 'package:university_attendance/feature/intro/welcome/presentation/welcome_view.dart';
class UserSettings extends StatefulWidget {
  const UserSettings({super.key});

  @override
  State<UserSettings> createState() => _UserSettingsState();
}

class _UserSettingsState extends State<UserSettings> {
  Future _signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColors.blueColor,
        foregroundColor: AppColors.whiteColor,
        title: const Text(
          'الاعدادات',
          style: TextStyle(color: AppColors.whiteColor),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            SettingsListItem(
              icon: Icons.person,
              text: 'إعدادات الحساب',
              onTap: () {
                push(context, const UserDetails());
              },
            ),
            SettingsListItem(
              icon: Icons.security_rounded,
              text: 'كلمة السر',
              onTap: () {
                push(context, NewPasswordDoctor());
              },
            ),
            SettingsListItem(
              icon: Icons.notifications_active_rounded,
              text: 'إعدادات الاشعارات',
              onTap: () {},
            ),
            SettingsListItem(
              icon: Icons.privacy_tip_rounded,
              text: 'الخصوصية',
              onTap: () {},
            ),
            SettingsListItem(
              icon: Icons.question_mark_rounded,
              text: 'المساعدة والدعم',
              onTap: () {},
            ),
            SettingsListItem(
              icon: Icons.person_add_alt_1_rounded,
              text: 'دعوة صديق',
              onTap: () {},
            ),
            const Spacer(),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 5),
              padding: const EdgeInsets.symmetric(horizontal: 14),
              height: 50,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: AppColors.redColor,
              ),
              child: TextButton(
                onPressed: () {
                  _signOut();
                  pushAndRemoveUntil(context, const WelcomeView());
                },
                child: Text(
                  'تسجل خروج',
                  style:
                      getTitleStyle(color: AppColors.whiteColor, fontSize: 14),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
