import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomSliverAppBar extends StatelessWidget {
  const CustomSliverAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.transparent,
      leading: const CircleAvatar(
        radius: 30,
        backgroundImage: AssetImage(
          "assets/images/user.png",
        ),
      ),
      centerTitle: false,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "سجاد حسين علي",
            style: Theme.of(context).textTheme.labelMedium,
          ),
          Text(
            "0771234567",
            style: Theme.of(context).textTheme.bodySmall,
          ),
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
