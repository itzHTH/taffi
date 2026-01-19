import 'package:flutter/material.dart';
import 'package:taffi/features/appointments/widgets/appointment_doctor_card.dart';

class SliverAppointmentList extends StatelessWidget {
  const SliverAppointmentList({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverList.builder(
      itemCount: 1,
      itemBuilder: (context, index) {
        return AppointmentDoctorCard(
          doctorName: "د. ليلى عبد العزيز",
          doctorSpecialization: "الجلدية والتجميل",
          rating: 4.5,
          doctorImage:
              "https://taafi.ddns.net/uploads/doctors/dr_layla.png",
          onBookCancelTap: () {},
          appointmentTime: "11:57",
          appointmentDate: '2026-01-22',
        );
      },
    );
  }
}
