import 'package:flutter/material.dart';
import 'package:taffi/core/widgets/big_doctor_card_shimmer.dart';

class DoctorSliderShimmer extends StatelessWidget {
  const DoctorSliderShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BigDoctorCardShimmer(),
        const SizedBox(height: 12),
        // Indicator shimmer
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            3,
            (index) => Container(
              width: 10,
              height: 10,
              margin: const EdgeInsets.symmetric(horizontal: 4),
              decoration: BoxDecoration(color: Colors.grey[300], shape: BoxShape.circle),
            ),
          ),
        ),
      ],
    );
  }
}
