import 'package:flutter/material.dart';
import 'package:taffi/features/Doctor_Info/screens/doctor_info.dart';
import 'package:taffi/features/Doctor_Info/widgets/doctor_info_card.dart';
import 'package:taffi/features/Doctor_Info/widgets/doctor_stats_section.dart';

class DoctorInfoHeader extends StatelessWidget {
  const DoctorInfoHeader({super.key, required this.widget});

  final DoctorInfoScreen widget;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DoctorInfoCard(doctorModel: widget.doctor),
        const SizedBox(height: 24),
        DoctorStatsSection(doctorModel: widget.doctor),
        const SizedBox(height: 24),
      ],
    );
  }
}
