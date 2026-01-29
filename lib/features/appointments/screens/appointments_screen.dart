import 'package:flutter/material.dart';
import 'package:taffi/core/theme/app_colors.dart';
import 'package:taffi/core/utils/snackbar_helper.dart';
import 'package:taffi/core/widgets/confirmation_dialog.dart';
import 'package:taffi/features/appointments/widgets/appointment_doctor_card.dart';

class AppointmentScreen extends StatefulWidget {
  const AppointmentScreen({super.key});

  @override
  State<AppointmentScreen> createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<AppointmentScreen> {
  late List<Map<String, dynamic>> appointments;

  @override
  void initState() {
    super.initState();
    appointments = [
      {
        'doctorName': 'د. ليلى عبد العزيز',
        'doctorSpecialization': 'الجلدية والتجميل',
        'rating': 4.5,
        'doctorImage': 'https://taafi.ddns.net/uploads/doctors/dr_layla.png',
        'appointmentTime': '11:57',
        'appointmentDate': '2026-01-22',
      },
      {
        'doctorName': 'د. أحمد محمود',
        'doctorSpecialization': 'أمراض القلب',
        'rating': 4.9,
        'doctorImage': 'https://taafi.ddns.net/uploads/doctors/dr_ahmed.png',
        'appointmentTime': '14:30',
        'appointmentDate': '2026-01-23',
      },
      {
        'doctorName': 'د. منى سامي',
        'doctorSpecialization': 'طب الأطفال',
        'rating': 4.7,
        'doctorImage': 'https://taafi.ddns.net/uploads/doctors/dr_mona.png',
        'appointmentTime': '10:00',
        'appointmentDate': '2026-01-24',
      },
    ];
  }

  Future<void> _showCancelConfirmationDialog(int index) async {
    final result = await ConfirmationDialog.show(
      context: context,
      type: ConfirmationDialogType.cancel,
      doctorName: appointments[index]['doctorName'] as String,
      appointmentDate: appointments[index]['appointmentDate'] as String,
      appointmentTime: appointments[index]['appointmentTime'] as String,
    );

    if (result == true && mounted) {
      _cancelAppointment(index);
    }
  }

  void _cancelAppointment(int index) {
    final canceledDoctor = appointments[index]['doctorName'];

    setState(() {
      appointments.removeAt(index);
    });

    SnackBarHelper.showSuccess(context, 'تم إلغاء الموعد مع $canceledDoctor بنجاح');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Text("جدول المواعيد", style: Theme.of(context).textTheme.titleLarge),
            centerTitle: true,
            automaticallyImplyLeading: false,
            backgroundColor: Colors.transparent,
            surfaceTintColor: Colors.transparent,
            elevation: 0,
          ),
          appointments.isEmpty
              ? SliverFillRemaining(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.event_busy, size: 80, color: AppColors.textHint),
                        const SizedBox(height: 16),
                        Text(
                          'لا توجد مواعيد',
                          style: Theme.of(
                            context,
                          ).textTheme.titleMedium?.copyWith(color: AppColors.textSecondary),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'جميع المواعيد المحجوزة ستظهر هنا',
                          style: Theme.of(
                            context,
                          ).textTheme.bodyMedium?.copyWith(color: AppColors.textHint),
                        ),
                      ],
                    ),
                  ),
                )
              : SliverList.builder(
                  itemCount: appointments.length,
                  itemBuilder: (context, index) {
                    final appointment = appointments[index];
                    return AppointmentDoctorCard(
                      doctorName: appointment['doctorName'] as String,
                      doctorSpecialization: appointment['doctorSpecialization'] as String,
                      rating: appointment['rating'] as double,
                      doctorImage: appointment['doctorImage'] as String,
                      appointmentTime: appointment['appointmentTime'] as String,
                      appointmentDate: appointment['appointmentDate'] as String,
                      onBookCancelTap: () => _showCancelConfirmationDialog(index),
                    );
                  },
                ),
        ],
      ),
    );
  }
}
