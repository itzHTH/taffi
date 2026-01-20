import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:taffi/features/notifications/screens/notifications_screen.dart';

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
            "Huthaifa M. Flayyih",
            style: Theme.of(context).textTheme.labelMedium,
          ),
          Text(
            "077428697555",
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
      actions: [
        Stack(
          children: [
            SizedBox(
              width: 60,
              height: 40,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          const NotificationsScreen(),
                    ),
                  );
                },
                child: SvgPicture.asset(
                  "assets/images/bell.svg",
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              top: 0,
              left: 0,

              child: Container(
                width: 14,
                height: 14,
                decoration: BoxDecoration(
                  color: Color(0xffFF1414),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xffFF1414),
                      blurRadius: 1,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
