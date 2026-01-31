import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taffi/core/enums/status_enum.dart';
import 'package:taffi/core/routing/route_names.dart';
import 'package:taffi/core/widgets/error_retry_widget.dart';
import 'package:taffi/core/widgets/specialty_card.dart';
import 'package:taffi/features/specialties/models/specialty_model.dart';
import 'package:taffi/features/specialties/providers/specialty_provider.dart';
import 'package:taffi/features/specialties/widgets/specialty_card_shimmer.dart';

class SliverSpecialtyGrid extends StatefulWidget {
  const SliverSpecialtyGrid({super.key, this.specialties});

  final List<SpecialtyModel>? specialties;

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
          return SliverFillRemaining(
            hasScrollBody: false,
            child: ErrorRetryWidget(
              errorMessage: provider.errorMessage ?? "حدث خطأ أثناء تحميل التخصصات",
              onRetry: () => provider.getSpecialties(),
            ),
          );
        }

        final displayList = widget.specialties ?? provider.specialties;
        return displayList.isEmpty
            ? SliverToBoxAdapter(child: Center(child: Text("لا توجد تخصصات حاليا")))
            : SliverGrid.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 0.58,
                ),
                itemCount: displayList.length,
                itemBuilder: (context, index) {
                  return SpecialtyCard(
                    title: displayList[index].name ?? "اسم التخصص",
                    imageUrl: displayList[index].iconUrl ?? "",
                    onTap: () {
                      provider.setSelectedSpecialty(displayList[index]);
                      Navigator.pushNamed(context, RouteNames.booking);
                    },
                  );
                },
              );
      },
    );
  }
}
