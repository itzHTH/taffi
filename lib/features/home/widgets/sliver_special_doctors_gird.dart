import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taffi/core/enums/status_enum.dart';
import 'package:taffi/core/routing/route_names.dart';
import 'package:taffi/core/widgets/error_retry_widget.dart';
import 'package:taffi/features/Doctor_Info/models/doctor_model.dart';
import 'package:taffi/features/Doctor_Info/providers/doctor_provider.dart';
import 'package:taffi/features/home/widgets/doctor_card_shimmer.dart';
import 'package:taffi/features/home/widgets/special_doctor_card.dart';

class SliverSpecialDoctorsGird extends StatefulWidget {
  const SliverSpecialDoctorsGird({super.key});

  @override
  State<SliverSpecialDoctorsGird> createState() => _SliverSpecialDoctorsGirdState();
}

class _SliverSpecialDoctorsGirdState extends State<SliverSpecialDoctorsGird> {
  void setDoctor(DoctorModel doctor) {
    final provider = context.read<DoctorProvider>();
    provider.setDoctor(doctor);
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<DoctorProvider>();

    // Show error state with retry
    if (provider.doctorsStatus == Status.error) {
      return SliverFillRemaining(
        hasScrollBody: false,
        child: ErrorRetryWidget(
          errorMessage: provider.errorMessage ?? "حدث خطأ أثناء تحميل الأطباء",
          onRetry: () => provider.getAllDoctors(),
        ),
      );
    }

    return SliverPadding(
      padding: const EdgeInsets.only(bottom: 12),
      sliver: SliverGrid.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 0.90,
        ),
        // Show 4 shimmer items while loading, otherwise show actual doctors
        itemCount: (provider.doctorsStatus == Status.loading || provider.doctors.isEmpty)
            ? 4
            : provider.doctors.length,
        itemBuilder: (context, index) {
          // Show shimmer while loading or empty
          if (provider.doctorsStatus == Status.loading || provider.doctors.isEmpty) {
            return const DoctorCardShimmer();
          }

          // Show actual doctor card
          final doctor = provider.doctors[index];
          return SpecialDoctorCard(
            doctorName: doctor.name ?? "اسم الدكتور",
            imageUrl: doctor.imageUrl ?? "",
            doctorSpecialty: doctor.specialtyName ?? "التخصص",
            rating: doctor.rate ?? 0.0,
            onTap: () {
              setDoctor(doctor);
              Navigator.pushNamed(context, RouteNames.doctorInfo, arguments: doctor);
            },
          );
        },
      ),
    );
  }
}
