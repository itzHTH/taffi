import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:taffi/core/enums/status_enum.dart';
import 'package:taffi/core/routing/route_names.dart';
import 'package:taffi/core/widgets/error_retry_widget.dart';
import 'package:taffi/features/auth/providers/user_provider.dart';
import 'package:taffi/features/profile/widgets/menu_item.dart';
import 'package:taffi/features/profile/widgets/user_details_widget.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: Text("ملفي الشخصي", style: Theme.of(context).textTheme.titleLarge),
        ),
        body: SafeArea(
          child: Consumer<UserProvider>(
            builder: (context, userProvider, child) {
              if (userProvider.loadUserStatus == Status.loading) {
                return const _ProfileScreenShimmer();
              }
              if (userProvider.loadUserStatus == Status.error) {
                return Center(
                  child: ErrorRetryWidget(
                    errorMessage: userProvider.errorMessage,
                    onRetry: () => userProvider.getUserInfo(),
                  ),
                );
              }
              // success
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    children: [
                      UserDetailsWidget(),
                      const SizedBox(height: 36),
                      MenuItem(
                        icon: 'assets/images/profile.svg',
                        title: "المعلومات الشخصيه",
                        onTap: () {
                          Navigator.pushNamed(context, RouteNames.userInfo);
                        },
                      ),
                      const SizedBox(height: 8),
                      MenuItem(
                        icon: 'assets/images/password.svg',
                        title: 'سياسة الخصوصية',
                        onTap: () {
                          Navigator.pushNamed(context, RouteNames.privacyPolicy);
                        },
                      ),
                      const SizedBox(height: 8),
                      MenuItem(
                        icon: 'assets/images/logout.svg',
                        title: 'تسجيل الخروج',
                        onTap: () async {
                          await userProvider.logout();
                          if (context.mounted) {
                            Navigator.pushNamedAndRemoveUntil(
                              context,
                              RouteNames.login,
                              (route) => false,
                            );
                          }
                        },
                      ),
                      const SizedBox(height: 8),
                      MenuItem(
                        useIconData: true,
                        iconData: Icons.help_outline_rounded,
                        title: 'من نحن',
                        onTap: () {
                          Navigator.pushNamed(context, RouteNames.aboutUs);
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class _ProfileScreenShimmer extends StatelessWidget {
  const _ProfileScreenShimmer();

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            // Profile Image Shimmer
            Container(
              width: 110,
              height: 110,
              decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.white),
            ),
            const SizedBox(height: 16),
            // Name Shimmer
            Container(
              width: 150,
              height: 20,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            const SizedBox(height: 8),
            // Phone Number Shimmer
            Container(
              width: 120,
              height: 16,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            const SizedBox(height: 36),
            // Menu Items Shimmer
            ...List.generate(
              4,
              (index) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Container(
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
