import 'package:dashed_border/dashed_border.dart';
import 'package:flutter/material.dart';
import 'package:taffi/core/theme/app_colors.dart';
import 'package:taffi/core/widgets/custom_cached_network_avatar.dart';

class AppointmentDoctorCard extends StatefulWidget {
  const AppointmentDoctorCard({
    super.key,
    required this.doctorName,
    required this.doctorSpecialization,
    required this.doctorImage,
    required this.onBookCancelTap,
    required this.appointmentTime,
    required this.appointmentDate,
    required this.isCompleted,
    required this.isCancelled,
  });

  final String doctorName;
  final String doctorSpecialization;
  final String doctorImage;
  final String appointmentTime;
  final VoidCallback onBookCancelTap;
  final bool isCompleted;
  final String appointmentDate;
  final bool isCancelled;

  @override
  State<AppointmentDoctorCard> createState() => _AppointmentDoctorCardState();
}

class _AppointmentDoctorCardState extends State<AppointmentDoctorCard>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: DashedBorder(
          color: AppColors.secondary,
          dashLength: 20,
          dashGap: 16,
          width: 1.5,
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      margin: EdgeInsets.symmetric(horizontal: 22, vertical: 8),
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 28),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              CustomCachedNetworkAvatar(imageUrl: widget.doctorImage, size: 60),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.doctorName,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: AppColors.secondary,
                      ),
                    ),
                    SizedBox(height: 4),
                    Row(
                      children: [
                        Text(
                          widget.doctorSpecialization,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Color(0xffA0A4B8),
                          ),
                        ),
                        SizedBox(width: 8),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),

          SizedBox(height: 20),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Color(0xffF5F7FA),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(Icons.calendar_today_rounded, color: Color(0xff677294), size: 20),
                ),
                SizedBox(width: 8),
                Text(
                  widget.appointmentDate,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Color(0xff677294),
                  ),
                ),
                Spacer(),
                Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Color(0xffF5F7FA),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(Icons.access_time_rounded, color: Color(0xff677294), size: 20),
                ),
                SizedBox(width: 8),
                Text(
                  widget.appointmentTime,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Color(0xff677294),
                  ),
                ),
                Spacer(),
              ],
            ),
          ),

          SizedBox(height: 20),

          widget.isCancelled
              ? SizedBox(
                  child: Text(
                    "تم الغاء الموعد",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppColors.secondary,
                    ),
                  ),
                )
              : widget.isCompleted
              ? SizedBox(
                  child: Text(
                    "الموعد مكتمل",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppColors.secondary,
                    ),
                  ),
                )
              : SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: widget.onBookCancelTap,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xffE8F3F1),
                      foregroundColor: AppColors.primary,
                      elevation: 0,
                      padding: EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
                    ),
                    child: Text(
                      "الغاء الموعد",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppColors.secondary,
                      ),
                    ),
                  ),
                ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
