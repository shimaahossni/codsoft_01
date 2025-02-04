// feature/patient/presentation/views/profile/presentation/views/patient_new_password.dart
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:university_attendance/core/utils/colors.dart';
import 'package:university_attendance/core/utils/text_style.dart';
import 'package:university_attendance/core/widgets/textfieldflorm_widget.dart';

class PatientNewPassword extends StatefulWidget {
  const PatientNewPassword({super.key});

  @override
  State<PatientNewPassword> createState() => _PatientNewPasswordState();
}

class _PatientNewPasswordState extends State<PatientNewPassword> {
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? user;

  Future<void> _getUser() async {
    try {
      user = _auth.currentUser;

      if (user == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('No user is signed in. Please log in first.'),
          ),
        );
      } else {
        setState(() {});
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetching user data: $e')),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _getUser();
  }

  Future<void> _updatePassword() async {
    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('No user is signed in. Please log in first.'),
        ),
      );
      return;
    }

    if (formKey.currentState?.validate() == true) {
      if (passwordController.text.trim() !=
          confirmPasswordController.text.trim()) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Passwords do not match')),
        );
        return;
      }

      try {
        await user!.updatePassword(passwordController.text.trim());
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Password updated successfully')),
        );
        Navigator.pop(context);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to update password: $e')),
        );
      }
    }
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.blueColor,
        foregroundColor: AppColors.whiteColor,
        centerTitle: true,
        title: const Text(
          'تغيير كلمة السر',
          style: TextStyle(color: AppColors.whiteColor),
        ),
      ),
      body: user == null
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('No user is signed in. Please log in.'),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context); // Redirect to login screen
                    },
                    child: const Text('Go Back'),
                  ),
                ],
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('كلمة السر الجديدة',
                        style: getBodyStyle(fontSize: 24)),
                    const Gap(20),
                    TextfieldflormWidget(
                      isobsecure: true,
                      hinttext: 'ادخل كلمة السر الجديدة',
                      controller: passwordController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'يرجى إدخال كلمة السر الجديدة';
                        }
                        if (value.length < 6) {
                          return 'يجب أن تكون كلمة السر 6 أحرف على الأقل';
                        }
                        return null;
                      },
                    ),
                    const Gap(20),
                    Text('تأكيد كلمة السر', style: getBodyStyle(fontSize: 24)),
                    const Gap(20),
                    TextfieldflormWidget(
                      controller: confirmPasswordController,
                      isobsecure: true,
                      hinttext: 'أعد إدخال كلمة السر',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'يرجى تأكيد كلمة السر';
                        }
                        return null;
                      },
                    ),
                    const Gap(20),
                    Center(
                      child: SizedBox(
                        height: 50,
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _updatePassword,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.blueColor,
                            foregroundColor: AppColors.whiteColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          child: Text(
                            'تغيير كلمة السر',
                            style: getTitleStyle(color: AppColors.whiteColor),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
