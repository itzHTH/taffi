import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:taffi/core/theme/app_colors.dart';
import 'package:taffi/core/widgets/rating_badge.dart';

class SpecialDoctorCard extends StatelessWidget {
  const SpecialDoctorCard({
    super.key,
    required this.imageUrl,
    required this.doctorName,
    required this.doctorSpecialty,
    required this.rating,
    required this.onTap,
  });

  final String imageUrl;
  final String doctorName;
  final String doctorSpecialty;
  final double rating;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      elevation: 3,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: AppColors.secondary,
                  ),
                  height: 140,
                  width: double.infinity,
                  child: CachedNetworkImage(
                    imageUrl: imageUrl,
                    fit: BoxFit.contain,
                    placeholder: (context, url) => Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: Container(
                        width: double.infinity,
                        height: 140,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error, color: Colors.red),
                    fadeInCurve: Curves.bounceIn,
                  ),
                ),
                Positioned(left: 6, top: 8, child: RatingBadge(rating: rating)),
              ],
            ),
            SizedBox(height: 8),
            Text(doctorName, style: Theme.of(context).textTheme.titleMedium),
            SizedBox(height: 4),
            Text(doctorSpecialty, style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
      ),
    );
  }
}
