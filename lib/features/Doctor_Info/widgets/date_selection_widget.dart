import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taffi/core/theme/app_colors.dart';
import 'package:taffi/core/utils/helpers.dart';
import 'package:taffi/features/Doctor_Info/providers/doctor_provider.dart';

class DateSelectionWidget extends StatefulWidget {
  const DateSelectionWidget({super.key});

  @override
  State<DateSelectionWidget> createState() => _DateSelectionWidgetState();
}

class _DateSelectionWidgetState extends State<DateSelectionWidget> {
  List<int> workDays = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final doctor = context.read<DoctorProvider>().doctor;
      if (doctor != null && doctor.scheduleDays != null) {
        workDays = doctor.scheduleDays!
            .map((day) => Helpers.getDayOfWeekIndex(day.dayOfWeek!))
            .toList();
      }
    });
  }

  // to get the first valid date (if today is not valid, skip to the next valid date)
  DateTime _getValidInitialDate() {
    DateTime date = DateTime.now();
    while (!workDays.contains(date.weekday)) {
      date = date.add(const Duration(days: 1));
    }
    return date;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'اختيار موعد الحجز',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87),
          ),
          const SizedBox(height: 12),
          Selector<DoctorProvider, DateTime?>(
            selector: (context, provider) => provider.selectedDate,
            builder: (context, selectedDate, child) {
              return ElevatedButton(
                onPressed: () async {
                  final selectedDatePicker = await showDatePicker(
                    context: context,
                    initialDate: _getValidInitialDate(),
                    firstDate: _getValidInitialDate(),
                    lastDate: DateTime.now().add(const Duration(days: 30)),
                    builder: (context, child) {
                      return Theme(
                        data: ThemeData(
                          colorScheme: ColorScheme.light(
                            primary: AppColors.primary,
                            onPrimary: Colors.white,
                            onSurface: Colors.black,
                          ),
                        ),
                        child: child!,
                      );
                    },
                    selectableDayPredicate: (DateTime day) {
                      return workDays.contains(day.weekday);
                    },
                  );

                  if (!context.mounted) return;
                  if (selectedDatePicker == null) return;
                  context.read<DoctorProvider>().setSelectedDate(selectedDatePicker);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFAFAFC),
                  foregroundColor: Colors.black,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                    side: BorderSide(color: Colors.grey[200]!, width: 2),
                  ),
                  fixedSize: Size(MediaQuery.of(context).size.width - 48, 56),
                ),
                child: Text(
                  selectedDate == null
                      ? 'اختر موعد'
                      : "موعدك هو : ${Helpers.formatDate(selectedDate)}",
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
