import 'package:flutter/material.dart';
import 'package:taffi/core/theme/app_colors.dart';

class CustomRefreshIndicator extends StatelessWidget {
  final Widget child;
  final Future<void> Function() onRefresh;
  final Color? color;
  final Color? backgroundColor;
  final double strokeWidth;
  final double displacement;
  final double edgeOffset;

  const CustomRefreshIndicator({
    super.key,
    required this.child,
    required this.onRefresh,
    this.color,
    this.backgroundColor,
    this.strokeWidth = 3.0,
    this.displacement = 60,
    this.edgeOffset = 0,
  });

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: onRefresh,
      color: color ?? AppColors.secondary,
      backgroundColor: backgroundColor ?? Colors.white,
      strokeWidth: strokeWidth,
      displacement: displacement,
      edgeOffset: edgeOffset,
      notificationPredicate: (notification) {
        return notification.depth == 0;
      },
      child: child,
    );
  }
}
