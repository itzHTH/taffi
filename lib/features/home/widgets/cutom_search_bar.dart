import 'package:flutter/material.dart';
import 'package:taffi/core/theme/app_colors.dart';

class CutomSearchBar extends StatelessWidget {
  const CutomSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 240,
      height: 46,
      child: SearchAnchor.bar(
        suggestionsBuilder: (context, controller) {
          return [];
        },
        barHintText: 'ابحث عن طبيب او تخصص',
        barHintStyle: WidgetStatePropertyAll(TextStyle(fontSize: 14)),
        barLeading: Icon(Icons.search, color: AppColors.primary),
        barPadding: WidgetStatePropertyAll(EdgeInsets.all(6)),
        barBackgroundColor: WidgetStatePropertyAll(Colors.transparent),
        barElevation: WidgetStatePropertyAll(0),
        barShape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(22),
            side: BorderSide(color: AppColors.primary, width: 1.5),
          ),
        ),
      ),
    );
  }
}
