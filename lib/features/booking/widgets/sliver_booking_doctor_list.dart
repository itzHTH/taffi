import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taffi/core/enums/status_enum.dart';
import 'package:taffi/core/routing/route_names.dart';
import 'package:taffi/core/widgets/big_doctor_card.dart';
import 'package:taffi/core/widgets/big_doctor_card_shimmer.dart';
import 'package:taffi/features/Doctor_Info/providers/doctor_provider.dart';

class SliverBookingDoctorList extends StatelessWidget {
  const SliverBookingDoctorList({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<DoctorProvider>(
      builder: (context, doctorProvider, child) {
        if (doctorProvider.doctorsBySpecialtyStatus == Status.loading) {
          return SliverToBoxAdapter(
            child: Center(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: 5,
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: BigDoctorCardShimmer(),
                ),
              ),
            ),
          );
        } else if (doctorProvider.doctorsBySpecialtyStatus == Status.error) {
          return SliverToBoxAdapter(
            child: Center(child: Text('حصل خطأ ما', style: Theme.of(context).textTheme.titleLarge)),
          );
        }
        return doctorProvider.doctorsBySpecialty.isEmpty
            ? SliverToBoxAdapter(
                child: Center(
                  child: Text('لا يوجد أطباء', style: Theme.of(context).textTheme.titleLarge),
                ),
              )
            : SliverList.builder(
                itemCount: doctorProvider.doctorsBySpecialty.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                    child: BigDoctorCard(
                      doctorName: doctorProvider.doctorsBySpecialty[index].name!,
                      doctorSpecialization: doctorProvider.doctorsBySpecialty[index].specialtyName!,
                      rating: doctorProvider.doctorsBySpecialty[index].rate!,
                      doctorImage: doctorProvider.doctorsBySpecialty[index].imageUrl!,
                      doctorLocation: doctorProvider.doctorsBySpecialty[index].location!,
                      onBookingTap: () {
                        Navigator.pushNamed(
                          context,
                          RouteNames.doctorInfo,
                          arguments: doctorProvider.doctorsBySpecialty[index],
                        );
                      },

                      isDashedBorder: true,
                    ),
                  );
                },
              );
      },
    );
  }
}
