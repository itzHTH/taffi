import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomSliverAppBar extends StatelessWidget {
  const CustomSliverAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      title: Hero(
        tag: "specialtiesTitle",
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset("assets/images/server.svg", width: 28),
            SizedBox(width: 8),
            Flexible(
              child: Text(
                "التخصصات الطبية",
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
          ],
        ),
      ),

      automaticallyImplyLeading: false,
      actionsPadding: const EdgeInsets.symmetric(horizontal: 16),
      actions: [
        IconButton(
          icon: SvgPicture.asset("assets/images/arrow-left.svg", width: 36),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],
      centerTitle: true,
      backgroundColor: Colors.transparent,
    );
  }
}
