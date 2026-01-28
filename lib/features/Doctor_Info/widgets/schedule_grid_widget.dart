import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taffi/features/Doctor_Info/providers/doctor_provider.dart';
import 'package:taffi/features/Doctor_Info/widgets/schedule_slot_item.dart';

class ScheduleGridWidget extends StatelessWidget {
  const ScheduleGridWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'المواعيد المتاحة',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87),
          ),

          const SizedBox(height: 6),

          Consumer<DoctorProvider>(
            builder: (context, provider, child) => provider.timeSlots.isEmpty
                ? const SizedBox(
                    height: 100,
                    child: Center(child: Text('قم باختيار تاريخ , للحصول على المواعيد المتاحة')),
                  )
                : GridView.builder(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 2.5,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                    ),
                    itemCount: provider.timeSlots.length,
                    itemBuilder: (context, index) {
                      return ScheduleSlotItem(
                        schedule: provider.timeSlots[index],
                        isSelected: provider.selectedScheduleIndex == index,
                        onTap: () => context.read<DoctorProvider>().setSelectedScheduleIndex(index),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
