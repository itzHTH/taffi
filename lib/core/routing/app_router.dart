import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taffi/core/routing/route_names.dart';
import 'package:taffi/features/Doctor%20Info/screens/doctor_info.dart';
import 'package:taffi/features/appointments/screens/appointments_screen.dart';
import 'package:taffi/features/auth/providers/register_provider.dart';
import 'package:taffi/features/auth/screens/fill_personal_info_screen.dart';
import 'package:taffi/features/auth/screens/login_screen.dart';
import 'package:taffi/features/auth/screens/register_screen.dart';
import 'package:taffi/features/booking/screens/booking_screen.dart';
import 'package:taffi/features/chat/screens/chat_screen.dart';
import 'package:taffi/features/home/screens/main_screen.dart';
import 'package:taffi/features/messages/screens/messages_screen.dart';
import 'package:taffi/features/notifications/screens/notifications_screen.dart';
import 'package:taffi/features/profile/screens/about_us_screen.dart';
import 'package:taffi/features/profile/screens/privacy_policy_screen.dart';
import 'package:taffi/features/profile/screens/profile_screen.dart';
import 'package:taffi/features/profile/screens/user_info_screen.dart';
import 'package:taffi/features/specialties/screens/specialties_screen.dart';
import 'package:taffi/features/splash/screens/splash_screen.dart';

/// Centralized routing management
class AppRouter {
  // Prevent creating instance from the class
  AppRouter._();

  /// Route generator
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      // Auth routes
      case RouteNames.splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());

      case RouteNames.login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());

      case RouteNames.register:
        return MaterialPageRoute(builder: (_) => const RegisterScreen());

      case RouteNames.fillPersonalInfo:
        final args = settings.arguments as Map<String, dynamic>?;
        final isGoogle = args?['isFromGoogle'] ?? false;
        return MaterialPageRoute(
          builder: (_) => ChangeNotifierProvider.value(
            value: RegisterProvider()..isGoogleLogin = isGoogle,
            child: const FillPersonalInfoScreen(),
          ),
        );

      // Main routes
      case RouteNames.main:
        return MaterialPageRoute(builder: (_) => const MainScreen());

      // Doctor routes
      case RouteNames.doctorInfo:
        return MaterialPageRoute(builder: (_) => const DoctorInfoScreen());

      // Booking routes
      case RouteNames.booking:
        return MaterialPageRoute(builder: (_) => const BookingScreen());

      // Profile routes
      case RouteNames.profile:
        return MaterialPageRoute(builder: (_) => const ProfileScreen());

      case RouteNames.userInfo:
        return MaterialPageRoute(builder: (_) => const UserInfoScreen());

      case RouteNames.aboutUs:
        return MaterialPageRoute(builder: (_) => const AboutUsScreen());

      case RouteNames.privacyPolicy:
        return MaterialPageRoute(builder: (_) => const PrivacyPolicyScreen());

      // Other routes
      case RouteNames.specialties:
        return MaterialPageRoute(builder: (_) => const SpecialtiesScreen());

      case RouteNames.appointments:
        return MaterialPageRoute(builder: (_) => const AppointmentScreen());

      case RouteNames.messages:
        return MaterialPageRoute(builder: (_) => const MessagesScreen());

      case RouteNames.chat:
        return MaterialPageRoute(builder: (_) => const ChatScreen());

      case RouteNames.notifications:
        return MaterialPageRoute(builder: (_) => const NotificationsScreen());

      // Default route (404)
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            appBar: AppBar(title: const Text('خطأ')),
            body: const Center(child: Text('الصفحة غير موجودة')),
          ),
        );
    }
  }
}
