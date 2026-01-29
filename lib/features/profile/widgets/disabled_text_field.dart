import 'package:flutter/material.dart';
import 'package:taffi/core/theme/app_colors.dart';

class DisabledTextField extends StatelessWidget {
  const DisabledTextField({super.key, required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<TextEditingValue>(
      valueListenable: controller,
      builder: (context, value, child) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          decoration: BoxDecoration(
            color: AppColors.backgroundLight.withValues(alpha: 0.5),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.primary.withValues(alpha: 0.3), width: 1.4),
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  value.text,
                  style: TextStyle(fontSize: 16, color: AppColors.textSecondary),
                ),
              ),
              Icon(Icons.lock_outline, color: AppColors.textSecondary, size: 20),
            ],
          ),
        );
      },
    );
  }
}
