import 'package:flutter/material.dart';
import 'package:taffi/features/Doctor_Info/widgets/date_selection_shimmer.dart';
import 'package:taffi/features/Doctor_Info/widgets/schedule_shimmer.dart';

class ShimmerBodyWidget extends StatelessWidget {
  const ShimmerBodyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const DateSelectionShimmer(),
        const SizedBox(height: 24),
        const ScheduleShimmer(),
        const SizedBox(height: 24),
      ],
    );
  }
}
