import 'package:flutter/material.dart';
import 'package:taffi/features/home/widgets/special_doctor_card.dart';

class SliverSpecialDoctorsGird extends StatefulWidget {
  const SliverSpecialDoctorsGird({super.key});

  @override
  State<SliverSpecialDoctorsGird> createState() =>
      _SliverSpecialDoctorsGirdState();
}

class _SliverSpecialDoctorsGirdState extends State<SliverSpecialDoctorsGird> {
  List<Map<String, dynamic>> specialDoctors = [
    {
      "name": "د. عمر فاروق",
      "imageUrl": "https://taafi.ddns.net/uploads/doctors/dr_omar.png",
      "specialty": "طب العيون",
      "rating": 4.60,
    },
    {
      "name": "د. منى سامي",
      "imageUrl": "https://taafi.ddns.net/uploads/doctors/dr_mona.png",
      "specialty": "أنف وأذن وحنجرة",
      "rating": 5.00,
    },
    {
      "name": "د. علي حسين كاظم",
      "imageUrl": "https://taafi.ddns.net/uploads/doctors/dr_ali.png",
      "specialty": "طب الأطفال",
      "rating": 4.90,
    },
    {
      "name": "د. نور الهدى",
      "imageUrl": "https://taafi.ddns.net/uploads/doctors/dr_noor.png",
      "specialty": "طب الأسنان",
      "rating": 4.40,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.only(bottom: 12),
      sliver: SliverGrid.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 0.90,
        ),

        itemCount: specialDoctors.length,
        itemBuilder: (context, index) {
          return SpecialDoctorCard(
            doctorName: specialDoctors[index]["name"] ?? "اسم الدكتور",
            imageUrl: specialDoctors[index]["imageUrl"] ?? "",
            doctorSpecialty: specialDoctors[index]["specialty"] ?? "التخصص",
            rating: specialDoctors[index]["rating"] ?? 0.0,
          );
        },
      ),
    );
  }
}
