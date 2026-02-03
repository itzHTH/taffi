import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taffi/core/enums/status_enum.dart';
import 'package:taffi/core/widgets/error_retry_widget.dart';
import 'package:taffi/features/Doctor_Info/providers/doctor_provider.dart';
import 'package:taffi/features/Doctor_Info/widgets/book_appointment_button.dart';
import 'package:taffi/features/Doctor_Info/widgets/date_selection_widget.dart';
import 'package:taffi/features/Doctor_Info/widgets/schedule_grid_widget.dart';
import 'package:taffi/features/Doctor_Info/widgets/shimmer_body_widget.dart';

class DateAndBookBodyWidget extends StatelessWidget {
  const DateAndBookBodyWidget({super.key, required this.onBookingPressed});

  final Future<void> Function()? onBookingPressed;

  @override
  Widget build(BuildContext context) {
    return Selector<DoctorProvider, Status>(
      selector: (context, ref) => ref.doctorStatus,
      builder: (context, status, child) {
        return Column(
          children: [
            switch (status) {
              Status.loading => ShimmerBodyWidget(),
              Status.error => ErrorRetryWidget(
                onRetry: () => context.read<DoctorProvider>().getDoctorSchedule(
                  context.read<DoctorProvider>().doctor!.id!,
                ),
                errorMessage:
                    context.read<DoctorProvider>().errorMessage ?? "حدث خطأ أثناء تحميل المواعيد",
              ),
              Status.success => Column(
                children: [
                  DateSelectionWidget(),
                  const SizedBox(height: 24),
                  ScheduleGridWidget(),
                  const SizedBox(height: 12),
                  BookAppointmentButton(onPressed: onBookingPressed),
                  const SizedBox(height: 12),
                ],
              ),
              _ => SizedBox.shrink(),
            },
          ],
        );
      },
    );
  }
}
