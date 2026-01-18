import 'package:dashed_border/dashed_border.dart';
import 'package:flutter/material.dart';
import 'package:taffi/core/theme/app_colors.dart';
import 'package:taffi/core/widgets/custom_cached_network_avatar.dart';
import 'package:taffi/features/home/widgets/rating_badge.dart';

class BigDoctorCard extends StatefulWidget {
  const BigDoctorCard({
    super.key,
    required this.doctorName,
    required this.doctorSpecialization,
    required this.rating,
    required this.doctorImage,
    required this.doctorLocation,
    required this.onBookingTap,

    this.isDashedBorder = false,
  });

  final String doctorName;
  final String doctorSpecialization;
  final double rating;
  final String doctorImage;
  final String doctorLocation;
  final VoidCallback onBookingTap;
  final bool isDashedBorder;

  @override
  State<BigDoctorCard> createState() => _BigDoctorCardState();
}

class _BigDoctorCardState extends State<BigDoctorCard>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      decoration: BoxDecoration(
        color: widget.isDashedBorder ? Colors.transparent : AppColors.secondary,
        borderRadius: BorderRadius.circular(12),
        border: widget.isDashedBorder
            ? DashedBorder(
                color: AppColors.primary,
                dashLength: 20,
                dashGap: 16,
                width: 1.5,
                borderRadius: BorderRadius.circular(12),
              )
            : null,
      ),
      height: 200,
      width: 200,
      margin: EdgeInsets.symmetric(horizontal: 18),
      padding: EdgeInsets.symmetric(horizontal: 36),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CustomCachedNetworkAvatar(imageUrl: widget.doctorImage, size: 70),
              SizedBox(width: 18),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.doctorName,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: widget.isDashedBorder
                          ? Colors.black
                          : Colors.white,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        widget.doctorSpecialization,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: widget.isDashedBorder
                              ? Color(0xff8F8F8F)
                              : Color(0XFFBBBBBB),
                        ),
                      ),
                      SizedBox(width: 8),
                      RatingBadge(rating: widget.rating),
                    ],
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 28),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.location_on,
                color: widget.isDashedBorder
                    ? Color(0xff8F8F8F)
                    : Color(0XFFBBBBBB),
              ),
              SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "الموقع",
                      style: TextStyle(
                        color: widget.isDashedBorder
                            ? Color(0xff8F8F8F)
                            : Color(0xffBBBBBB),
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      widget.doctorLocation,
                      style: TextStyle(
                        color: widget.isDashedBorder
                            ? Color(0xff8F8F8F)
                            : Color(0xffBBBBBB),
                        fontSize: 14,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ],
                ),
              ),
              SizedBox(width: 34),
              ElevatedButton(
                onPressed: widget.onBookingTap,
                style: ElevatedButton.styleFrom(
                  backgroundColor: widget.isDashedBorder
                      ? AppColors.secondary
                      : Colors.white,
                  foregroundColor: widget.isDashedBorder
                      ? Colors.white
                      : Colors.black,
                ),
                child: Text(
                  "احجز  الأن",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
