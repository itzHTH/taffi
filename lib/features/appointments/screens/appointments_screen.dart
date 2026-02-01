import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taffi/core/enums/status_enum.dart';
import 'package:taffi/core/widgets/custom_refresh_indicator.dart';
import 'package:taffi/core/utils/helpers.dart';
import 'package:taffi/core/utils/snackbar_helper.dart';
import 'package:taffi/core/widgets/confirmation_dialog.dart';
import 'package:taffi/core/widgets/error_retry_widget.dart';
import 'package:taffi/features/appointments/models/appointment_model.dart';
import 'package:taffi/features/appointments/providers/appointment_provider.dart';
import 'package:taffi/features/appointments/widgets/appointment_doctor_card.dart';
import 'package:taffi/features/appointments/widgets/appointment_shimmer_card.dart';
import 'package:taffi/features/appointments/widgets/empty_appointment_list.dart';

class AppointmentScreen extends StatefulWidget {
  const AppointmentScreen({super.key});

  @override
  State<AppointmentScreen> createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<AppointmentScreen> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  Future<void> _showCancelConfirmationDialog(int index) async {
    final appointmentProvider = context.read<AppointmentProvider>();
    AppointmentModel appointmentModel = appointmentProvider.appointmentsResponse[index];
    final result = await ConfirmationDialog.show(
      context: context,
      type: ConfirmationDialogType.cancel,
      doctorName: appointmentModel.doctorName ?? '',
      appointmentDate: appointmentModel.formattedDate,
      appointmentTime: appointmentModel.formattedTime,
    );

    if (result == true && mounted) {
      await _cancelAppointment(index);
    }
  }

  Future<void> _cancelAppointment(int index) async {
    final canceledAppointmentId = context
        .read<AppointmentProvider>()
        .appointmentsResponse[index]
        .id;

    await context.read<AppointmentProvider>().cancelAppointment(canceledAppointmentId!);
    if (mounted) {
      await context.read<AppointmentProvider>().getAppointments();
    }

    if (mounted) {
      SnackBarHelper.showSuccess(context, 'تم إلغاء الموعد بنجاح');
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return CustomRefreshIndicator(
      onRefresh: () => context.read<AppointmentProvider>().getAppointments(),
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              title: Text("جدول المواعيد", style: Theme.of(context).textTheme.titleLarge),
              centerTitle: true,
              automaticallyImplyLeading: false,
              floating: false,
              snap: false,
              pinned: true,
              scrolledUnderElevation: 0,
              backgroundColor: Colors.transparent,
              surfaceTintColor: Colors.transparent,
              elevation: 0,
            ),
            Consumer<AppointmentProvider>(
              builder: (context, appointmentProvider, child) {
                // Show shimmer while loading
                if (appointmentProvider.status == Status.loading) {
                  return SliverList.builder(
                    itemCount: 3,
                    itemBuilder: (context, index) => const AppointmentShimmerCard(),
                  );
                }

                if (appointmentProvider.status == Status.error) {
                  return SliverFillRemaining(
                    hasScrollBody: false,
                    child: Center(
                      child: ErrorRetryWidget(
                        errorMessage:
                            appointmentProvider.errorMessage ?? "حدث خطأ أثناء تحميل المواعيد",
                        onRetry: () => appointmentProvider.getAppointments(),
                      ),
                    ),
                  );
                }

                // Show empty state if no appointments
                if (appointmentProvider.appointmentsResponse.isEmpty) {
                  return const EmptyAppointmentList();
                }

                // Show appointments list
                return SliverList.builder(
                  itemCount: appointmentProvider.appointmentsResponse.length,
                  itemBuilder: (context, index) {
                    final appointment = appointmentProvider.appointmentsResponse[index];

                    bool isCompleted = Helpers.isDateTimeBeforeNow(
                      appointment.appointmentDate!,
                      appointment.appointmentTime!,
                    );
                    return AppointmentDoctorCard(
                      doctorName: appointment.doctorName ?? "اسم الطبيب",
                      doctorSpecialization: appointment.specialtyName ?? "التخصص",
                      doctorImage: appointment.doctorImage ?? "",
                      appointmentTime: appointment.formattedTime,
                      appointmentDate: appointment.formattedDate,
                      onBookCancelTap: () => _showCancelConfirmationDialog(index),

                      isCompleted: isCompleted,
                      isCancelled: appointment.status == "Cancelled",
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
