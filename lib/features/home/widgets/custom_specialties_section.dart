import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:taffi/core/widgets/specialty_card.dart';
import 'package:taffi/features/booking/screens/booking_screen.dart';
import 'package:taffi/features/specialties/screens/specialties_screen.dart';

class CustomSpecialtiesSection extends StatelessWidget {
  CustomSpecialtiesSection({super.key});

  final List<Map<String, String>> specialties = [
    {
      "imageUrl":
          "https://taafi.ddns.net/uploads/specialties/derma.svg",
      "title": "الجلدية والتجميل",
    },
    {
      "imageUrl":
          "https://taafi.ddns.net/uploads/specialties/ent.svg",
      "title": "أنف وأذن وحنجرة",
    },
    {
      "imageUrl":
          "https://taafi.ddns.net/uploads/specialties/eye.svg",
      "title": "طب العيون",
    },
    {
      "imageUrl":
          "https://taafi.ddns.net/uploads/specialties/heart.svg",
      "title": "أمراض القلب",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Hero(
              tag: "specialtiesTitle",
              child: Row(
                children: [
                  SvgPicture.asset(
                    "assets/images/server.svg",
                    width: 28,
                  ),
                  SizedBox(width: 8),
                  Text(
                    "التخصصات الطبية",
                    style: Theme.of(
                      context,
                    ).textTheme.labelSmall,
                  ),
                ],
              ),
            ),
            Spacer(),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        SpecialtiesScreen(),
                  ),
                );
              },
              child: Text(
                "عرض الكل",
                style: Theme.of(
                  context,
                ).textTheme.labelSmall,
              ),
            ),
          ],
        ),
        SizedBox(height: 6),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: List.generate(
            4,
            (index) => SpecialtyCard(
              imageUrl: specialties[index]["imageUrl"]!,
              title: specialties[index]["title"]!,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BookingScreen(),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
