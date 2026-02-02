import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:taffi/core/theme/app_colors.dart';

class CustomSliverAppBar extends StatelessWidget {
  const CustomSliverAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      title: Hero(
        tag: "specialtiesTitle",
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset("assets/images/server.svg", width: 28),
            SizedBox(width: 8),
            Flexible(child: Text("التخصصات الطبية", style: Theme.of(context).textTheme.titleLarge)),
          ],
        ),
      ),

      leading: IconButton(
        highlightColor: Colors.black.withValues(alpha: 0.2),
        icon: Icon(Icons.arrow_back_ios_new_outlined, color: AppColors.primary),
        onPressed: () {
          Navigator.pop(context);
        },
      ),

      centerTitle: true,
      backgroundColor: AppColors.surface,
    );
  }
}
