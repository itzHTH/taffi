import 'package:flutter/material.dart';

class RatingBadge extends StatelessWidget {
  const RatingBadge({
    super.key,
    required this.rating,
    this.textColor = Colors.white,
    this.hasBackground = true,
  });

  final double rating;
  final Color textColor;
  final bool hasBackground;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 4,
      ),
      decoration: BoxDecoration(
        color: hasBackground
            ? Colors.amber.withAlpha(150)
            : null,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Icon(
            Icons.star_rounded,
            color: Colors.amber,
            size: 22,
          ),
          const SizedBox(width: 4),
          Text(
            "$rating",
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14,
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }
}
