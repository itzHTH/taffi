import 'package:flutter/material.dart';
import 'package:taffi/core/theme/app_colors.dart';

enum SnackBarType { success, error, info }

class SnackBarHelper {
  SnackBarHelper._();

  static void showSnackBar(
    BuildContext context, {
    required String message,
    required SnackBarType type,
    Duration duration = const Duration(seconds: 3),
  }) {
    final snackBar = SnackBar(
      content: Row(
        children: [
          Icon(_getIcon(type), color: Colors.white, size: 24),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              message,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
      backgroundColor: _getColor(type),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.all(16),
      duration: duration,
      elevation: 6,
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static void showSuccess(
    BuildContext context,
    String message, {
    Duration duration = const Duration(seconds: 3),
  }) {
    showSnackBar(context, message: message, type: SnackBarType.success, duration: duration);
  }

  static void showError(
    BuildContext context,
    String message, {
    Duration duration = const Duration(seconds: 3),
  }) {
    showSnackBar(context, message: message, type: SnackBarType.error, duration: duration);
  }

  static void showInfo(
    BuildContext context,
    String message, {
    Duration duration = const Duration(seconds: 3),
  }) {
    showSnackBar(context, message: message, type: SnackBarType.info, duration: duration);
  }

  static Color _getColor(SnackBarType type) {
    switch (type) {
      case SnackBarType.success:
        return const Color(0xFF4CAF50); // Green
      case SnackBarType.error:
        return const Color(0xFFE53935); // Red
      case SnackBarType.info:
        return AppColors.primary; // Primary color
    }
  }

  static IconData _getIcon(SnackBarType type) {
    switch (type) {
      case SnackBarType.success:
        return Icons.check_circle_outline;
      case SnackBarType.error:
        return Icons.error_outline;
      case SnackBarType.info:
        return Icons.info_outline;
    }
  }
}
