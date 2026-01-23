import 'package:flutter/material.dart';
import 'package:taffi/core/data/local/secure_storage.dart';
import 'package:taffi/core/theme/app_colors.dart';
import 'package:taffi/features/auth/screens/login_screen.dart';
import 'package:taffi/features/profile/screens/about_us_screen.dart';
import 'package:taffi/features/profile/screens/privacy_policy_screen.dart';
import 'package:taffi/features/profile/screens/user_info_screen.dart';
import 'package:taffi/features/profile/widgets/menu_item.dart';

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
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
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
                  Text("Huthaifa M. Flayyih", style: Theme.of(context).textTheme.titleMedium),

                  Text("Leader@", style: Theme.of(context).textTheme.headlineSmall),
                  const SizedBox(height: 36),
                  MenuItem(
                    icon: 'assets/images/profile.svg',
                    title: "المعلومات الشخصيه",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const UserInfoScreen()),
                      );
                    },
                  ),
                  const SizedBox(height: 8),
                  MenuItem(
                    icon: 'assets/images/password.svg',
                    title: 'سياسة الخصوصية',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const PrivacyPolicyScreen()),
                      );
                    },
                  ),
                  const SizedBox(height: 8),
                  MenuItem(
                    icon: 'assets/images/logout.svg',
                    title: 'تسجيل الخروج',
                    onTap: () async {
                      final storage = SecureStorage.instance;
                      await storage.deleteTokens();
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => const LoginScreen()),
                        (route) => false,
                      );
                    },
                  ),
                  const SizedBox(height: 8),
                  MenuItem(
                    useIconData: true,
                    iconData: Icons.help_outline_rounded,
                    title: 'من نحن',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const AboutUsScreen()),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
