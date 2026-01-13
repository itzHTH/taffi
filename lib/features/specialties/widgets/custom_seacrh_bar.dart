import 'package:flutter/material.dart';
import 'package:taffi/core/theme/app_colors.dart';

class CustomSeacrhBar extends StatelessWidget {
  const CustomSeacrhBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 240,
      height: 45,
      child: SearchBar(
        hintText: "ابحث عن تخصص",
        hintStyle: WidgetStatePropertyAll(TextStyle(fontSize: 14)),

        leading: Icon(Icons.search, color: AppColors.primary),
        backgroundColor: WidgetStatePropertyAll(Colors.transparent),
        elevation: WidgetStatePropertyAll(0),
        padding: WidgetStatePropertyAll(EdgeInsets.all(6)),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
            side: BorderSide(color: AppColors.primary),
          ),
        ),
      ),
    );
  }
}
