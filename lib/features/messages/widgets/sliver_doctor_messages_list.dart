import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taffi/core/enums/status_enum.dart';
import 'package:taffi/core/routing/route_names.dart';
import 'package:taffi/features/Doctor_Info/providers/doctor_provider.dart';
import 'package:taffi/features/messages/widgets/doctor_message_card.dart';
import 'package:taffi/features/messages/widgets/doctor_message_shimmer.dart';

class SliverDoctorMessagesList extends StatefulWidget {
  const SliverDoctorMessagesList({super.key});

  @override
  State<SliverDoctorMessagesList> createState() => _SliverDoctorMessagesListState();
}

class _SliverDoctorMessagesListState extends State<SliverDoctorMessagesList> {
  @override
  Widget build(BuildContext context) {
    return Consumer<DoctorProvider>(
      builder: (context, doctorProvider, child) {
        if (doctorProvider.doctorsStatus == Status.loading) {
          return SliverList.builder(
            itemCount: 10,
            itemBuilder: (context, index) {
              return const Padding(
                padding: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                child: DoctorMessageShimmer(),
              );
            },
          );
        }

        // Show empty state if no doctors
        if (doctorProvider.doctors.isEmpty) {
          return SliverToBoxAdapter(
            child: Center(
              child: Text("لا يوجد محادثات", style: Theme.of(context).textTheme.headlineMedium),
            ),
          );
        }

        // Show actual doctor cards
        return SliverList.builder(
          itemCount: doctorProvider.doctors.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
              child: DoctorMessageCard(
                imageUrl: doctorProvider.doctors[index].imageUrl ?? "",
                doctor: doctorProvider.doctors[index],
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    RouteNames.chat,
                    arguments: doctorProvider.doctors[index],
                  );
                },
              ),
            );
          },
        );
      },
    );
  }
}
