import 'package:flutter/material.dart';
import 'package:taffi/core/theme/app_colors.dart';
import 'package:taffi/core/widgets/rating_badge.dart';
import 'package:taffi/features/Doctor_Info/models/doctor_model.dart';

class DoctorInfoCard extends StatelessWidget {
  const DoctorInfoCard({super.key, required this.doctorModel});

  final DoctorModel? doctorModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                doctorModel?.name ?? "",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black87),
              ),
              RatingBadge(rating: doctorModel?.rate ?? 0.0, textColor: AppColors.textPrimary),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            doctorModel?.specialtyName ?? "",
            style: TextStyle(fontSize: 14, color: Colors.black54),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Icon(Icons.location_on, size: 18, color: Colors.black54),
              SizedBox(width: 8),
              Text(
                doctorModel?.location ?? "",
                style: TextStyle(fontSize: 14, color: Colors.black54),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
