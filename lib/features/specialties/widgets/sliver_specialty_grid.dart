import 'package:flutter/material.dart';
import 'package:taffi/core/widgets/specialty_card.dart';

class SliverSpecialtyGrid extends StatefulWidget {
  const SliverSpecialtyGrid({super.key});

  @override
  State<SliverSpecialtyGrid> createState() => _SliverSpecialtyGridState();
}

class _SliverSpecialtyGridState extends State<SliverSpecialtyGrid> {
  final List<Map<String, String>> specialties = [
    {
      "name": "الجلدية والتجميل",
      "iconUrl": "https://taafi.ddns.net/uploads/specialties/derma.svg",
    },
    {
      "name": "أنف وأذن وحنجرة",
      "iconUrl": "https://taafi.ddns.net/uploads/specialties/ent.svg",
    },
    {
      "name": "طب العيون",
      "iconUrl": "https://taafi.ddns.net/uploads/specialties/eye.svg",
    },
    {
      "name": "أمراض القلب",
      "iconUrl": "https://taafi.ddns.net/uploads/specialties/heart.svg",
    },
    {
      "name": "طب الأطفال",
      "iconUrl": "https://taafi.ddns.net/uploads/specialties/baby.svg",
    },
    {
      "name": "العظام والمفاصل",
      "iconUrl": "https://taafi.ddns.net/uploads/specialties/bone.svg",
    },
    {
      "name": "طب الأسنان",
      "iconUrl": "https://taafi.ddns.net/uploads/specialties/tooth.svg",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return SliverGrid.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 0.58,
      ),
      itemCount: specialties.length,
      itemBuilder: (context, index) {
        return SpecialtyCard(
          title: specialties[index]['name'] ?? "اسم التخصص",
          imageUrl: specialties[index]['iconUrl'] ?? "",
          onTap: () {},
        );
      },
    );
  }
}
