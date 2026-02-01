import 'package:flutter/material.dart';
import 'package:taffi/core/theme/app_colors.dart';

class EmptyAppointmentList extends StatelessWidget {
  const EmptyAppointmentList({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverFillRemaining(
      hasScrollBody: false,
      fillOverscroll: true,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.event_busy, size: 80, color: AppColors.textHint),
            const SizedBox(height: 16),
            Text(
              'لا توجد مواعيد',
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(color: AppColors.textSecondary),
            ),
            const SizedBox(height: 8),
            Text(
              'جميع المواعيد المحجوزة ستظهر هنا',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.textHint),
            ),
          ],
        ),
      ),
    );
  }
}
