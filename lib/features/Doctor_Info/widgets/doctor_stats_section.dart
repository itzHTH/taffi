import 'package:flutter/material.dart';
import 'package:taffi/features/Doctor_Info/models/doctor_model.dart';
import 'package:taffi/features/Doctor_Info/widgets/stat_item.dart';

class DoctorStatsSection extends StatelessWidget {
  const DoctorStatsSection({super.key, this.doctorModel});

  final DoctorModel? doctorModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          StatItem(value: doctorModel?.experienceYears.toString() ?? "", label: 'الخبره'),
          StatItem(
            value: "${((doctorModel?.experienceYears ?? 0) + 13).toString()}+",
            label: 'المرضى',
          ),
          StatItem(
            value: "${((doctorModel?.experienceYears ?? 0) * 2000).toString()} د.أ",
            label: 'الكشفيه',
          ),
        ],
      ),
    );
  }
}
