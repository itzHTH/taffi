import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomSliverAppBar extends StatelessWidget {
  const CustomSliverAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.transparent,
      title: Hero(
        tag: "SpecialName",
        child: Text(
          "امراض القلب",
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      pinned: true,
      centerTitle: true,
      actions: [
        IconButton(
          icon: SvgPicture.asset("assets/images/arrow-left.svg", width: 36),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}
