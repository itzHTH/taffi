import 'package:flutter/material.dart';
import 'package:taffi/core/theme/app_colors.dart';
import 'package:taffi/features/Doctor%20Info/widgets/book_appointment_button.dart';
import 'package:taffi/features/Doctor%20Info/widgets/custom_sliver_app_bar.dart';
import 'package:taffi/features/Doctor%20Info/widgets/date_selection_widget.dart';
import 'package:taffi/features/Doctor%20Info/widgets/doctor_info_card.dart';
import 'package:taffi/features/Doctor%20Info/widgets/doctor_stats_section.dart';
import 'package:taffi/features/Doctor%20Info/widgets/schedule_grid_widget.dart';

class DoctorInfoScreen extends StatefulWidget {
  const DoctorInfoScreen({super.key});

  @override
  State<DoctorInfoScreen> createState() => _DoctorInfoScreenState();
}

class _DoctorInfoScreenState extends State<DoctorInfoScreen> {
  int? selectedScheduleIndex = 0;

  final List<String> schedules = [
    '10:30am - 11:30am',
    '11:30am - 12:30pm',
    '12:30am - 1:30pm',
    '2:30am - 3:30pm',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondary,
      body: CustomScrollView(
        slivers: [
          CustomSliverAppBar(),
          SliverToBoxAdapter(
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(36),
                  topRight: Radius.circular(36),
                ),
              ),
              child: Column(
                children: [
                  const SizedBox(height: 2),
                  Divider(
                    color: Colors.grey[400],
                    thickness: 4,
                    endIndent: MediaQuery.of(context).size.width / 2.3,
                    indent: MediaQuery.of(context).size.width / 2.3,
                    radius: BorderRadius.circular(100),
                  ),
                  const SizedBox(height: 24),
                  const DoctorInfoCard(),
                  const SizedBox(height: 24),
                  const DoctorStatsSection(),
                  const SizedBox(height: 24),
                  DateSelectionWidget(),
                  const SizedBox(height: 24),
                  ScheduleGridWidget(
                    schedules: schedules,
                    selectedScheduleIndex: selectedScheduleIndex,
                    onScheduleSelected: (index) {
                      setState(() => selectedScheduleIndex = index);
                    },
                  ),
                  const SizedBox(height: 24),
                  const BookAppointmentButton(),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
