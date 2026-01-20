import 'package:flutter/material.dart';
import 'package:taffi/core/theme/app_colors.dart';

class ContentParagraph extends StatelessWidget {
  const ContentParagraph({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 15,
        height: 1.6,
        color: AppColors.textPrimary,
      ),
      textAlign: TextAlign.justify,
    );
  }
}
