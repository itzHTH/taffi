import 'package:flutter/material.dart';
import 'package:taffi/core/theme/app_colors.dart';

class CustomSliverAppBar extends StatelessWidget {
  const CustomSliverAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.transparent,
      automaticallyImplyLeading: false,
      title: Hero(
        tag: "SpecialName",
        child: Text(
          "امراض القلب",
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      pinned: true,
      centerTitle: true,
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back_ios_new_outlined,
          color: AppColors.primary,
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}
