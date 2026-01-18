import 'package:flutter/material.dart';
import 'package:taffi/core/theme/app_colors.dart';

class DateSelectionWidget extends StatefulWidget {
  const DateSelectionWidget({super.key});

  @override
  State<DateSelectionWidget> createState() => _DateSelectionWidgetState();
}

class _DateSelectionWidgetState extends State<DateSelectionWidget> {
  DateTime? selectedDate;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'اختيار موعد الحجز',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 12),
          ElevatedButton(
            onPressed: () async {
              final selectedDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime.now(),
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
                  if (day.weekday == DateTime.tuesday ||
                      day.weekday == DateTime.wednesday ||
                      day.weekday == DateTime.thursday ||
                      day.weekday == DateTime.friday) {
                    return false;
                  }
                  return true;
                },
              );

              setState(() {
                this.selectedDate = selectedDate;
              });
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
                  : "موعدك هو : ${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}",
            ),
          ),
        ],
      ),
    );
  }
}
