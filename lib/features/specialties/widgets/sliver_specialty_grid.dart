import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taffi/core/enums/status_enum.dart';
import 'package:taffi/core/routing/route_names.dart';
import 'package:taffi/core/widgets/specialty_card.dart';
import 'package:taffi/features/specialties/providers/specialty_provider.dart';
import 'package:taffi/features/specialties/widgets/specialty_card_shimmer.dart';

class SliverSpecialtyGrid extends StatefulWidget {
  const SliverSpecialtyGrid({super.key});
  @override
  State<SliverSpecialtyGrid> createState() => _SliverSpecialtyGridState();
}

class _SliverSpecialtyGridState extends State<SliverSpecialtyGrid> {
  @override
  Widget build(BuildContext context) {
    return Consumer<SpecialtyProvider>(
      builder: (context, provider, child) {
        if (provider.specialtiesStatus == Status.loading) {
          return SliverGrid(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 0.58,
            ),
            delegate: SliverChildBuilderDelegate(
              (context, index) => const SpecialtyCardShimmer(),
              childCount: 8,
            ),
          );
        }
        if (provider.specialtiesStatus == Status.error) {
          return SliverToBoxAdapter(child: Center(child: Text(provider.errorMessage)));
        }
        return provider.specialties.isEmpty
            ? SliverToBoxAdapter(child: Center(child: Text("لا توجد تخصصات حاليا")))
            : SliverGrid.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 0.58,
                ),
                itemCount: provider.specialties.length,
                itemBuilder: (context, index) {
                  return SpecialtyCard(
                    title: provider.specialties[index].name ?? "اسم التخصص",
                    imageUrl: provider.specialties[index].iconUrl ?? "",
                    onTap: () {
                      provider.setSelectedSpecialty(provider.specialties[index]);
                      Navigator.pushNamed(context, RouteNames.booking);
                    },
                  );
                },
              );
      },
    );
  }
}
