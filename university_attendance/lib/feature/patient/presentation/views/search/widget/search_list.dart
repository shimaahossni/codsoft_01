// feature/patient/presentation/views/search/widget/search_list.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:university_attendance/core/widgets/doctor_card.dart';
import 'package:university_attendance/feature/auth/login/data/doctor_model.dart';
import 'package:university_attendance/feature/patient/presentation/views/home/oresentation/widget/no_doctor_found.dart';

class SearchList extends StatefulWidget {
  final String searchKey;
  const SearchList({super.key, required this.searchKey});

  @override
  State<SearchList> createState() => _SearchListState();
}

class _SearchListState extends State<SearchList> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('doctors')
          .orderBy('name')
          .startAt([widget.searchKey]).endAt(
              ['${widget.searchKey}\uf8ff']).snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return snapshot.data!.docs.isEmpty
            ? const NoDoctorFound()
            : Scrollbar(
                child: ListView.builder(
                  itemCount: snapshot.data?.docs.length,
                  itemBuilder: (context, index) {
                    DoctorModel doctor = DoctorModel.fromJson(
                      snapshot.data!.docs[index].data() as Map<String, dynamic>,
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
    );
  }
}
