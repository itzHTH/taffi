import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taffi/core/theme/app_colors.dart';
import 'package:taffi/features/specialties/providers/specialty_provider.dart';

class CustomSliverAppBar extends StatelessWidget {
  const CustomSliverAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.transparent,
      automaticallyImplyLeading: false,
      title: Hero(
        tag: Provider.of<SpecialtyProvider>(context).selectedSpecialty!.name!,
        child: Text(
          Provider.of<SpecialtyProvider>(context).selectedSpecialty!.name!,
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      pinned: true,
      centerTitle: true,
      leading: IconButton(
        highlightColor: Colors.black.withValues(alpha: 0.2),
        icon: Icon(Icons.arrow_back_ios_new_outlined, color: AppColors.primary),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}
