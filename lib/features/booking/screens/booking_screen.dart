import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taffi/features/Doctor_Info/providers/doctor_provider.dart';
import 'package:taffi/features/booking/widgets/custom_sliver_app_bar.dart';
import 'package:taffi/features/booking/widgets/sliver_booking_doctor_list.dart';
import 'package:taffi/features/specialties/providers/specialty_provider.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({super.key});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final selectedSpecialty = Provider.of<SpecialtyProvider>(
        context,
        listen: false,
      ).selectedSpecialty;
      Provider.of<DoctorProvider>(
        context,
        listen: false,
      ).getDoctorsBySpecialty(selectedSpecialty!.id!);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(slivers: [CustomSliverAppBar(), SliverBookingDoctorList()]),
    );
  }
}
