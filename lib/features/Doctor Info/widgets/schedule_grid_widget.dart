import 'package:flutter/material.dart';
import 'package:taffi/features/Doctor%20Info/widgets/schedule_slot_item.dart';

class ScheduleGridWidget extends StatelessWidget {
  final List<String> schedules;
  final int? selectedScheduleIndex;
  final void Function(int) onScheduleSelected;

  const ScheduleGridWidget({
    super.key,
    required this.schedules,
    this.selectedScheduleIndex,
    required this.onScheduleSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'المواعيد المتاحة',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),

          const SizedBox(height: 6),

          GridView.builder(
            padding: EdgeInsets.zero,

            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 2.5,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
            ),
            itemCount: schedules.length,
            itemBuilder: (context, index) {
              return ScheduleSlotItem(
                schedule: schedules[index],
                isSelected: selectedScheduleIndex == index,
                onTap: () => onScheduleSelected(index),
              );
            },
          ),
        ],
      ),
    );
  }
}
