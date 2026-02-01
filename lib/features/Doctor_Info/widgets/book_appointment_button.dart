import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taffi/core/enums/status_enum.dart';
import 'package:taffi/core/theme/app_colors.dart';
import 'package:taffi/features/appointments/providers/appointment_provider.dart';

class BookAppointmentButton extends StatefulWidget {
  final Future<void> Function()? onPressed;

  const BookAppointmentButton({super.key, this.onPressed});

  @override
  State<BookAppointmentButton> createState() => _BookAppointmentButtonState();
}

class _BookAppointmentButtonState extends State<BookAppointmentButton> {
  bool _isLoadingLocal = false;
  @override
  Widget build(BuildContext context) {
    return Consumer<AppointmentProvider>(
      builder: (context, ref, child) {
        final isLoadingState = ref.bookStatus == Status.loading || ref.status == Status.loading;
        return AbsorbPointer(
          absorbing: isLoadingState || _isLoadingLocal,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: () async {
                  if (isLoadingState || _isLoadingLocal) return;
                  setState(() {
                    _isLoadingLocal = true;
                  });
                  await widget.onPressed?.call();
                  setState(() {
                    _isLoadingLocal = false;
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.secondary,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  elevation: 2,
                ),
                child: isLoadingState
                    ? const Center(child: CircularProgressIndicator())
                    : const Text(
                        'حجز موعد',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
              ),
            ),
          ),
        );
      },
    );
  }
}
