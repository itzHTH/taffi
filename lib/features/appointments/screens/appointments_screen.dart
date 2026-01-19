import 'package:flutter/material.dart';
import 'package:taffi/features/appointments/widgets/sliver_appointment_list.dart';

class AppointmentScreen extends StatelessWidget {
  const AppointmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Text(
              "جدول المواعيد",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            centerTitle: true,
            automaticallyImplyLeading: false,
            backgroundColor: Colors.transparent,
            surfaceTintColor: Colors.transparent,

            elevation: 0,
          ),
          SliverAppointmentList(),
        ],
      ),
    );
  }
}
