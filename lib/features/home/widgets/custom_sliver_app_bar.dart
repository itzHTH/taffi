import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:taffi/core/enums/status_enum.dart';
import 'package:taffi/core/routing/route_names.dart';
import 'package:taffi/core/theme/app_colors.dart';
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
            return Row(
              children: [
                Expanded(
                  child: Text(
                    userProvider.errorMessage,
                    style: Theme.of(context).textTheme.labelMedium,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.refresh, color: AppColors.primary),
                  highlightColor: Colors.black.withValues(alpha: 0.2),
                  onPressed: () {
                    userProvider.getUserInfo();
                  },
                ),
              ],
            );
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                userProvider.user?.fullName ?? "مستخدم",
                style: Theme.of(context).textTheme.labelMedium,
              ),
              Text(
                userProvider.user?.phoneNumber ?? "",
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          );
        },
      ),
      actions: [
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
