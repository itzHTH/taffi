import 'package:flutter/material.dart';

/// Generic error banner for inline errors (like send message failures)
/// Shows a red banner with error message and retry button
class ErrorBanner extends StatelessWidget {
  final String? errorMessage;
  final VoidCallback onRetry;

  const ErrorBanner({super.key, this.errorMessage, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.red.shade50,
        border: Border.all(color: Colors.red.shade200),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(Icons.error_outline, color: Colors.red.shade700, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              errorMessage ?? "حدث خطأ",
              style: TextStyle(color: Colors.red.shade700, fontSize: 13),
            ),
          ),
          TextButton(
            onPressed: onRetry,
            style: TextButton.styleFrom(
              foregroundColor: Colors.red.shade700,
              padding: const EdgeInsets.symmetric(horizontal: 12),
            ),
            child: Text("اعد المحاولة"),
          ),
        ],
      ),
    );
  }
}
