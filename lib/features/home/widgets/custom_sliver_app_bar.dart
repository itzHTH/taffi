import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:taffi/core/enums/status_enum.dart';
import 'package:taffi/core/routing/route_names.dart';
import 'package:taffi/features/auth/providers/user_provider.dart';

class CustomSliverAppBar extends StatelessWidget {
  const CustomSliverAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.transparent,
      leading: const CircleAvatar(
        radius: 30,
        backgroundImage: AssetImage("assets/images/user.png"),
      ),
      centerTitle: false,
      title: Consumer<UserProvider>(
        builder: (context, userProvider, child) {
          if (userProvider.loadUserStatus == Status.loading) {
            return const _AppBarShimmer();
          } else if (userProvider.loadUserStatus == Status.error) {
            return Text("حدث خطأ ما", style: Theme.of(context).textTheme.labelMedium);
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                userProvider.user!.fullName ?? "",
                style: Theme.of(context).textTheme.labelMedium,
              ),
              Text(
                userProvider.user!.phoneNumber ?? "",
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          );
        },
      ),
      actions: [
        Stack(
          children: [
            SizedBox(
              width: 60,
              height: 40,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, RouteNames.notifications);
                },
                child: SvgPicture.asset("assets/images/bell.svg", fit: BoxFit.cover),
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
                  boxShadow: [BoxShadow(color: Color(0xffFF1414), blurRadius: 1)],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _AppBarShimmer extends StatelessWidget {
  const _AppBarShimmer();

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 120,
            height: 14,
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(4)),
          ),
          const SizedBox(height: 6),
          Container(
            width: 90,
            height: 12,
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(4)),
          ),
        ],
      ),
    );
  }
}
