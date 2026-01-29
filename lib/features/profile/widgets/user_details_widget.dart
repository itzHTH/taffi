import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taffi/core/enums/status_enum.dart';
import 'package:taffi/core/theme/app_colors.dart';
import 'package:taffi/features/auth/providers/user_provider.dart';

class UserDetailsWidget extends StatelessWidget {
  const UserDetailsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = context.read<UserProvider>();
    return Column(
      children: [
        Hero(
          tag: 'profile_image',
          child: Container(
            width: 110,
            height: 110,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey[200],
              image: const DecorationImage(
                image: AssetImage('assets/images/user.png'),
                fit: BoxFit.cover,
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withValues(alpha: 0.2),
                  blurRadius: 12,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        if (userProvider.loadUserStatus == Status.error)
          Text("حدث خطأ ما", style: Theme.of(context).textTheme.labelMedium)
        else if (userProvider.loadUserStatus == Status.success)
          Column(
            children: [
              Text(
                userProvider.user!.fullName ?? "",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 4),
              Text(
                "${userProvider.user!.userName}@",
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ],
          ),
      ],
    );
  }
}
