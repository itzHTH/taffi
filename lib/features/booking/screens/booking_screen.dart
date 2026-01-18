import 'package:flutter/material.dart';
import 'package:taffi/features/booking/widgets/custom_sliver_app_bar.dart';
import 'package:taffi/features/booking/widgets/sliver_booking_doctor_list.dart';

class BookingScreen extends StatelessWidget {
  const BookingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [CustomSliverAppBar(), SliverBookingDoctorList()],
      ),
    );
  }
}
