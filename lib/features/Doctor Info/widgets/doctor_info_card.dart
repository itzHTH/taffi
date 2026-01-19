import 'package:flutter/material.dart';
import 'package:taffi/core/theme/app_colors.dart';
import 'package:taffi/core/widgets/rating_badge.dart';

class DoctorInfoCard extends StatelessWidget {
  const DoctorInfoCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment:
                MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                "د. منى سامي",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              RatingBadge(
                rating: 5.00,
                textColor: AppColors.textPrimary,
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Text(
            "أنف وأذن وحنجرة | بغداد - شارع فلسطين",
            style: TextStyle(
              fontSize: 14,
              color: Colors.black54,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: const [
              Icon(
                Icons.access_time,
                size: 18,
                color: Colors.black54,
              ),
              SizedBox(width: 8),
              Text(
                "10:30am - 5:30pm",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
