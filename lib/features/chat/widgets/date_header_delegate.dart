import 'package:flutter/material.dart';

class DateHeaderDelegate extends SliverPersistentHeaderDelegate {
  final String date;

  DateHeaderDelegate(this.date);

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.9),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
        ),
        child: Text(
          date,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  @override
  double get maxExtent => 50.0; // أقصى ارتفاع للتاريخ

  @override
  double get minExtent => 50.0; // أقل ارتفاع (نفس القيمة ليبقى ثابتاً)

  @override
  bool shouldRebuild(covariant DateHeaderDelegate oldDelegate) {
    return oldDelegate.date != date;
  }
}
