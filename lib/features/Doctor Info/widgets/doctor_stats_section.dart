import 'package:flutter/material.dart';
import 'package:taffi/features/Doctor%20Info/widgets/stat_item.dart';

class DoctorStatsSection extends StatelessWidget {
  const DoctorStatsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: const [
          StatItem(value: '7yr', label: 'الخبره'),
          StatItem(value: '${7 * 4}+', label: 'المرضى'),
          StatItem(value: '${7 * 1000 + 5000} د.ع', label: 'الكشفيه'),
        ],
      ),
    );
  }
}
