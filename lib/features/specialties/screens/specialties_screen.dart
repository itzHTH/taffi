import 'package:flutter/material.dart';
import 'package:taffi/core/theme/app_colors.dart';
import 'package:taffi/features/specialties/widgets/custom_seacrh_bar.dart';
import 'package:taffi/features/specialties/widgets/custom_sliver_app_bar.dart';
import 'package:taffi/features/specialties/widgets/sliver_specialty_grid.dart';

class SpecialtiesScreen extends StatelessWidget {
  const SpecialtiesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: AppColors.surface,
        body: CustomScrollView(
          slivers: [
            CustomSliverAppBar(),
            SliverToBoxAdapter(child: SizedBox(height: 16)),
            SliverToBoxAdapter(
              child: Center(child: CustomSeacrhBar()),
            ),
            SliverToBoxAdapter(child: SizedBox(height: 16)),
            SliverPadding(
              sliver: SliverSpecialtyGrid(),
              padding: EdgeInsets.symmetric(horizontal: 16),
            ),
          ],
        ),
      ),
    );
  }
}
