import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taffi/core/enums/status_enum.dart';
import 'package:taffi/core/theme/app_colors.dart';
import 'package:taffi/features/appointments/providers/appointment_provider.dart';

class BookAppointmentButton extends StatelessWidget {
  final VoidCallback? onPressed;

  const BookAppointmentButton({super.key, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppointmentProvider>(
      builder: (context, ref, child) {
        bool isLoading = ref.bookStatus == Status.loading || ref.status == Status.loading;
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: SizedBox(
            width: double.infinity,
            height: 56,
            child: ElevatedButton(
              onPressed: isLoading ? null : onPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.secondary,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                elevation: 2,
              ),
              child: isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : const Text(
                      'حجز موعد',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
            ),
          ),
        );
      },
    );
  }
}
