import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taffi/core/routing/route_names.dart';
import 'package:taffi/core/theme/app_colors.dart';
import 'package:taffi/features/Doctor_Info/providers/doctor_provider.dart';
import 'package:taffi/features/home/widgets/suggestion_doctor_widget.dart';

class CutomSearchBar extends StatelessWidget {
  const CutomSearchBar({super.key});
  @override
  Widget build(BuildContext context) {
    final doctorProvider = Provider.of<DoctorProvider>(context, listen: false);
    final doctorsList = doctorProvider.doctors;

    return SizedBox(
      width: 210,
      height: 46,
      child: SearchAnchor.bar(
        suggestionsBuilder: (context, controller) {
          final suggestions = controller.text.isEmpty
              ? doctorsList.take(10).toList()
              : doctorsList.where((doctor) {
                  final searchQuery = controller.text.toLowerCase();
                  final doctorName = (doctor.name ?? '').toLowerCase();
                  final doctorSpecialty = (doctor.specialtyName ?? '').toLowerCase();
                  final doctorLocation = (doctor.location ?? '').toLowerCase();

                  return doctorName.contains(searchQuery) ||
                      doctorSpecialty.contains(searchQuery) ||
                      doctorLocation.contains(searchQuery);
                }).toList();

          if (suggestions.isEmpty) {
            return [
              Padding(
                padding: const EdgeInsets.all(32),
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.search_off_rounded, size: 64, color: Colors.grey[400]),
                      SizedBox(height: 16),
                      Text(
                        'لم يتم العثور على أطباء',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey[600],
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'حاول البحث باسم آخر أو تخصص مختلف',
                        style: TextStyle(fontSize: 13, color: Colors.grey[500]),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ];
          }

          final widgets = <Widget>[];

          if (controller.text.isEmpty) {
            widgets.add(
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 12),
                child: Row(
                  children: [
                    Icon(Icons.medical_services, color: AppColors.primary, size: 20),
                    SizedBox(width: 8),
                    Text(
                      'الأطباء المقترحون',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                    ),
                    Spacer(),
                    Text(
                      '${suggestions.length}',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else {
            // إضافة header لنتائج البحث
            widgets.add(
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 12),
                child: Row(
                  children: [
                    Icon(Icons.search, color: AppColors.primary, size: 20),
                    SizedBox(width: 8),
                    Text(
                      'نتائج البحث',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                    ),
                    Spacer(),
                    Text(
                      '${suggestions.length} نتيجة',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }

          widgets.addAll(
            suggestions.asMap().entries.map((entry) {
              final index = entry.key;
              final doctor = entry.value;

              return SuggestionDoctorWidget(
                doctor: doctor,
                index: index,
                onTap: () {
                  FocusScope.of(context).unfocus();
                  controller.closeView("");
                  doctorProvider.setDoctor(doctor);
                  Navigator.pushNamed(context, RouteNames.doctorInfo, arguments: doctor);
                },
              );
            }).toList(),
          );

          return widgets;
        },
        barHintText: 'ابحث عن طبيب او تخصص',
        barHintStyle: WidgetStatePropertyAll(TextStyle(fontSize: 14)),
        barLeading: Icon(Icons.search, color: AppColors.primary),
        barPadding: WidgetStatePropertyAll(EdgeInsets.all(6)),
        barBackgroundColor: WidgetStatePropertyAll(Colors.transparent),
        barElevation: WidgetStatePropertyAll(0),
        barShape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(22),
            side: BorderSide(color: AppColors.primary, width: 1.5),
          ),
        ),
      ),
    );
  }
}
