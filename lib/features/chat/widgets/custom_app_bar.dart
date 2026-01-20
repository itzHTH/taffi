import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:taffi/core/theme/app_colors.dart';
import 'package:taffi/core/widgets/custom_cached_network_avatar.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
      surfaceTintColor: Colors.transparent,
      shadowColor: Colors.black,
      elevation: 5,
      forceElevated: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      expandedHeight: 60,
      leadingWidth: 32,
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back_ios_new_outlined,
          color: AppColors.primary,
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      title: Row(
        children: [
          CustomCachedNetworkAvatar(
            imageUrl:
                "https://taafi.ddns.net/uploads/doctors/dr_mona.png",
            size: 56,
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "د. منى سامي",
                style: Theme.of(
                  context,
                ).textTheme.titleMedium,
              ),
              const SizedBox(height: 4),
              Text(
                "أنف وأذن وحنجرة",
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium,
              ),
            ],
          ),
        ],
      ),
      actions: [
        Text(
          "متصل ألأن",
          style: Theme.of(context).textTheme.bodySmall,
        ),
        const SizedBox(width: 8),
        SvgPicture.asset(
          "assets/images/is-connect.svg",
          width: 12,
          height: 12,
        ),
      ],
      actionsPadding: EdgeInsets.only(left: 28),
    );
  }
}
