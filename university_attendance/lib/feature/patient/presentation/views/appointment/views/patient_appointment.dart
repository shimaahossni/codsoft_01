// feature/patient/presentation/views/appointment/views/patient_appointment.dart
import 'package:flutter/material.dart';
import 'package:university_attendance/core/utils/colors.dart';
import 'package:university_attendance/feature/doctor/presentation/profile/widgets/appointments_list.dart';

class PatientAppointment extends StatelessWidget {
  const PatientAppointment({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.blueColor,
        foregroundColor: AppColors.whiteColor,
        centerTitle: true,
        title: const Text(
          'مواعيد الحجز',
        ),
      ),
      body: const Padding(
          padding: EdgeInsets.all(10), child: MyAppointmentsHistory()),
    );
  }
}
