import 'package:flutter/material.dart';
import 'package:taffi/core/routing/route_names.dart';
import 'package:taffi/core/widgets/big_doctor_card.dart';

class SliverBookingDoctorList extends StatefulWidget {
  const SliverBookingDoctorList({super.key});

  @override
  State<SliverBookingDoctorList> createState() => _SliverBookingDoctorListState();
}

class _SliverBookingDoctorListState extends State<SliverBookingDoctorList> {
  final List<Map<String, dynamic>> doctors = [
    {
      "name": "د. عمر فاروق",
      "imageUrl": "https://taafi.ddns.net/uploads/doctors/dr_omar.png",
      "specialization": "طب العيون",
      "rating": 4.60,
      "location": "ديالى",
    },
    {
      "name": "د. منى سامي",
      "imageUrl": "https://taafi.ddns.net/uploads/doctors/dr_mona.png",
      "specialization": "أنف وأذن وحنجرة",
      "rating": 5.00,
      "location": "انبار",
    },
    {
      "name": "د. علي حسين كاظم",
      "imageUrl": "https://taafi.ddns.net/uploads/doctors/dr_ali.png",
      "specialization": "طب الأطفال",
      "rating": 4.90,
      "location": "القاهرة",
    },
    {
      "name": "د. نور الهدى",
      "imageUrl": "https://taafi.ddns.net/uploads/doctors/dr_noor.png",
      "specialization": "طب الأسنان",
      "rating": 4.40,
      "location": "اربيل",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return SliverList.builder(
      itemCount: doctors.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
          child: BigDoctorCard(
            doctorName: doctors[index]["name"],
            doctorSpecialization: doctors[index]["specialization"],
            rating: doctors[index]["rating"],
            doctorImage: doctors[index]["imageUrl"],
            doctorLocation: doctors[index]["location"],
            onBookingTap: () {
              Navigator.pushNamed(context, RouteNames.doctorInfo);
            },

            isDashedBorder: true,
          ),
        );
      },
    );
  }
}
