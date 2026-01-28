import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taffi/core/theme/app_colors.dart';
import 'package:taffi/core/widgets/confirmation_dialog.dart';
import 'package:taffi/features/Doctor_Info/models/doctor_model.dart';
import 'package:taffi/features/Doctor_Info/providers/doctor_provider.dart';
import 'package:taffi/features/Doctor_Info/widgets/custom_sliver_app_bar.dart';
import 'package:taffi/features/Doctor_Info/widgets/date_and_book_body_widget.dart';
import 'package:taffi/features/Doctor_Info/widgets/doctor_info_header.dart';

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
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: const [
              Icon(Icons.info, color: Colors.white),
              SizedBox(width: 12),
              Expanded(child: Text('الرجاء اختيار موعد أولاً', style: TextStyle(fontSize: 15))),
            ],
          ),
          backgroundColor: AppColors.warning,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      );
      return;
    }

    final result = await ConfirmationDialog.show(
      context: context,
      type: ConfirmationDialogType.booking,
      doctorName: widget.doctor.name ?? "اسم الطبيب",
      appointmentDate: _doctorProvider.selectedDate!.toLocal().toString(),
      appointmentTime: _doctorProvider.timeSlots[_doctorProvider.selectedScheduleIndex!],
    );

    if (result == true && mounted) {
      _confirmBooking();
    }
  }

  void _confirmBooking() {
    // TODO: Make booking

    // show Done SnackBar
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: const [
            Icon(Icons.check_circle, color: Colors.white),
            SizedBox(width: 12),
            Expanded(
              child: Text(
                'تم تأكيد الحجز بنجاح! سيتم إرسال التفاصيل إلى بريدك الإلكتروني',
                style: TextStyle(fontSize: 15),
              ),
            ),
          ],
        ),
        backgroundColor: AppColors.success,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        duration: const Duration(seconds: 4),
      ),
    );
    Navigator.pop(context);
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
                constraints: BoxConstraints(
                  minHeight:
                      MediaQuery.of(context).size.height *
                      0.65, // 65% من الشاشة (المتبقي من 35% للـ AppBar)
                ),
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
