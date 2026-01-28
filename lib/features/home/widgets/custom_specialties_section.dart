import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:taffi/core/enums/status_enum.dart';
import 'package:taffi/core/routing/route_names.dart';
import 'package:taffi/core/widgets/specialty_card.dart';
import 'package:taffi/features/specialties/providers/specialty_provider.dart';
import 'package:taffi/features/specialties/widgets/specialty_card_shimmer.dart';

class CustomSpecialtiesSection extends StatelessWidget {
  const CustomSpecialtiesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Hero(
              tag: "specialtiesTitle",
              child: Row(
                children: [
                  SvgPicture.asset("assets/images/server.svg", width: 28),
                  SizedBox(width: 8),
                  Text("التخصصات الطبية", style: Theme.of(context).textTheme.labelSmall),
                ],
              ),
            ),
            Spacer(),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, RouteNames.specialties);
              },
              child: Text("عرض الكل", style: Theme.of(context).textTheme.labelSmall),
            ),
          ],
        ),
        SizedBox(height: 6),
        SpecialtiesRow(),
      ],
    );
  }
}

class SpecialtiesRow extends StatefulWidget {
  const SpecialtiesRow({super.key});

  @override
  State<SpecialtiesRow> createState() => _SpecialtiesRowState();
}

class _SpecialtiesRowState extends State<SpecialtiesRow> {
  @override
  Widget build(BuildContext context) {
    return Consumer<SpecialtyProvider>(
      builder: (context, provider, child) {
        if (provider.specialtiesStatus == Status.loading) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(4, (index) => const SpecialtyCardShimmer()),
          );
        }

        if (provider.specialtiesStatus == Status.error) {
          return Center(
            child: Text(provider.errorMessage, style: TextStyle(color: Colors.red)),
          );
        }

        if (provider.specialties.isEmpty) {
          return Center(child: Text("لا توجد تخصصات حاليا"));
        }

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: List.generate(
            4,
            (index) => SpecialtyCard(
              imageUrl: provider.specialties[index].iconUrl ?? "",
              title: provider.specialties[index].name ?? "التخصص",
              hasHero: false,
              onTap: () {
                provider.setSelectedSpecialty(provider.specialties[index]);
                Navigator.pushNamed(context, RouteNames.booking);
              },
            ),
          ),
        );
      },
    );
  }
}
