import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:taffi/core/widgets/custom_cached_network_avatar.dart';

class CustomSliverAppBar extends StatelessWidget {
  const CustomSliverAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.transparent,
      leading: CustomCachedNetworkAvatar(
        imageUrl: "https://taafi.ddns.net/uploads/doctors/dr_ahmed.png",
        size: 70,
      ),
      centerTitle: false,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("سجاد حسين علي", style: Theme.of(context).textTheme.labelMedium),
          Text("0771234567", style: Theme.of(context).textTheme.bodySmall),
        ],
      ),
      actions: [
        SizedBox(
          width: 60,
          height: 40,
          child: ElevatedButton(
            onPressed: () {},
            child: SvgPicture.asset(
              "assets/images/bell.svg",
              fit: BoxFit.cover,
            ),
          ),
        ),
      ],
    );
  }
}
