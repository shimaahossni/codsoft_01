// feature/patient/presentation/views/home/oresentation/widget/specialization_search_screen.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:university_attendance/core/widgets/doctor_card.dart';
import 'package:university_attendance/feature/auth/login/data/doctor_model.dart';
import 'package:university_attendance/feature/patient/presentation/views/home/oresentation/widget/no_specialization_found.dart';

class SpecializationSearchScreen extends StatefulWidget {
  final String specialization;

  const SpecializationSearchScreen({super.key, required this.specialization});

  @override
  State<SpecializationSearchScreen> createState() =>
      _SpecializationSearchScreenState();
}

class _SpecializationSearchScreenState
    extends State<SpecializationSearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.specialization,
        ),
      ),
      body: FutureBuilder(
        future: FirebaseFirestore.instance
            .collection('doctors')
            .where('specialization', isEqualTo: widget.specialization)
            .get(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return snapshot.data!.docs.isEmpty
              ? const NoSpecializationFound()
              : Padding(
                  padding: const EdgeInsets.all(15),
                  child: ListView.builder(
                    physics: const ClampingScrollPhysics(),
                    itemCount: snapshot.data?.docs.length,
                    itemBuilder: (context, index) {
                      DoctorModel doctor = DoctorModel.fromJson(
                        snapshot.data!.docs[index].data()
                            as Map<String, dynamic>,
                      );
                      if (doctor.specialization == '') {
                        return const SizedBox();
                      }
                      return DoctorCard(
                        doctor: doctor,
                      );
                    },
                  ),
                );
        },
      ),
    );
  }
}
