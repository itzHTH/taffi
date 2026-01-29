import 'package:dashed_border/dashed_border.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:taffi/core/theme/app_colors.dart';

class AppointmentShimmerCard extends StatelessWidget {
  const AppointmentShimmerCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: DashedBorder(
          color: AppColors.secondary.withValues(alpha: 0.3),
          dashLength: 20,
          dashGap: 16,
          width: 1.5,
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 22, vertical: 8),
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 28),
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                // Avatar shimmer
                Container(
                  width: 60,
                  height: 60,
                  decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Doctor name shimmer
                      Container(
                        width: double.infinity,
                        height: 18,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      const SizedBox(height: 8),
                      // Specialization shimmer
                      Container(
                        width: 120,
                        height: 14,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                children: [
                  // Date icon shimmer
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  const SizedBox(width: 8),
                  // Date text shimmer
                  Container(
                    width: 80,
                    height: 14,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  const Spacer(),
                  // Time icon shimmer
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  const SizedBox(width: 8),
                  // Time text shimmer
                  Container(
                    width: 60,
                    height: 14,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  const Spacer(),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // Cancel button shimmer
            Container(
              width: double.infinity,
              height: 48,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(32),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
