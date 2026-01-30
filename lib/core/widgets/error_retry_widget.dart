import 'package:flutter/material.dart';

/// Generic error widget with retry button
/// Can be used anywhere in the app to show errors with retry functionality
class ErrorRetryWidget extends StatelessWidget {
  final String? errorMessage;
  final VoidCallback onRetry;
  final IconData? icon;
  final double iconSize;

  const ErrorRetryWidget({
    super.key,
    this.errorMessage,
    required this.onRetry,
    this.icon,
    this.iconSize = 80,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(icon ?? Icons.error_outline, size: iconSize, color: Colors.red),
            const SizedBox(height: 16),
            Text(
              errorMessage ?? "حدث خطأ ما",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh),
              label: const Text("إعادة المحاولة"),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
