import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taffi/core/enums/status_enum.dart';
import 'package:taffi/core/theme/app_colors.dart';
import 'package:taffi/core/utils/helpers.dart';
import 'package:taffi/core/utils/snackbar_helper.dart';
import 'package:taffi/core/widgets/confirmation_dialog.dart';
import 'package:taffi/features/Doctor_Info/models/doctor_model.dart';
import 'package:taffi/features/Doctor_Info/providers/doctor_provider.dart';
import 'package:taffi/features/Doctor_Info/widgets/custom_sliver_app_bar.dart';
import 'package:taffi/features/Doctor_Info/widgets/date_and_book_body_widget.dart';
import 'package:taffi/features/Doctor_Info/widgets/doctor_info_header.dart';
import 'package:taffi/features/appointments/providers/appointment_provider.dart';

class DoctorInfoScreen extends StatefulWidget {
  const DoctorInfoScreen({super.key, required this.doctor});

  final DoctorModel doctor;

  @override
  State<DoctorInfoScreen> createState() => _DoctorInfoScreenState();
}

class _DoctorInfoScreenState extends State<DoctorInfoScreen> {
  late DoctorProvider _doctorProvider;

  @override
  void initState() {
    super.initState();
    _doctorProvider = context.read<DoctorProvider>();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Set the doctor first (important for specialty screen flow)
      _doctorProvider.setDoctor(widget.doctor);
      // Then load the schedule
      _doctorProvider.getDoctorSchedule(widget.doctor.id!);
    });
  }

  @override
  void dispose() {
    if (!context.mounted) {
      _doctorProvider.reset();
    }
    super.dispose();
  }

  Future<void> _showBookingConfirmationDialog() async {
    // if no schedule is not selected
    if (_doctorProvider.selectedScheduleIndex == null) {
      SnackBarHelper.showInfo(context, 'الرجاء اختيار موعد أولاً');
      return;
    }

    final result = await ConfirmationDialog.show(
      context: context,
      type: ConfirmationDialogType.booking,
      doctorName: widget.doctor.name ?? "اسم الطبيب",
      appointmentDate: Helpers.formatDate(_doctorProvider.selectedDate!),
      appointmentTime: _doctorProvider.timeSlots[_doctorProvider.selectedScheduleIndex!],
    );

    if (result == true && mounted) {
      _confirmBooking();
    }
  }

  void _confirmBooking() async {
    final appointmentProvider = context.read<AppointmentProvider>();
    // Book the appointment
    await appointmentProvider.bookAppointment(
      doctorId: widget.doctor.id!,
      appointmentDate: _doctorProvider.selectedDate!.toIso8601String(),
      appointmentTime: Helpers.formatTimeOfDay(
        _doctorProvider.timeSlots[_doctorProvider.selectedScheduleIndex!],
      ),
      patientNotes: "",
    );

    if (!mounted) return;
    // Check if the appointment was booked successfully
    if (appointmentProvider.bookStatus == Status.success) {
      // Get the appointments
      await appointmentProvider.getAppointments();
      if (!mounted) return;
      // Check if the appointments were fetched successfully
      if (appointmentProvider.status == Status.success) {
        SnackBarHelper.showSuccess(
          context,
          'تم تأكيد الحجز بنجاح! سيتم إرسال التفاصيل إلى بريدك الإلكتروني',
          duration: const Duration(seconds: 4),
        );
        Navigator.pop(context);
      } else {
        SnackBarHelper.showError(
          context,
          appointmentProvider.errorMessage ?? "حدث خطأ أثناء الحجز",
        );
      }
    } else {
      SnackBarHelper.showError(context, appointmentProvider.errorMessage ?? "حدث خطأ أثناء الحجز");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondary,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            CustomSliverAppBar(imageUrl: widget.doctor.imageUrl ?? ""),
            SliverToBoxAdapter(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: MediaQuery.of(context).size.height * 0.65),
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
                      DoctorInfoHeader(widget: widget),
                      DateAndBookBodyWidget(onBookingPressed: _showBookingConfirmationDialog),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
