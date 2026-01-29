import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taffi/core/routing/app_router.dart';
import 'package:taffi/core/routing/route_names.dart';
import 'package:taffi/core/services/navigation_service.dart';
import 'package:taffi/core/theme/app_theme.dart';
import 'package:taffi/features/Doctor_Info/providers/doctor_provider.dart';
import 'package:taffi/features/appointments/providers/appointment_provider.dart';
import 'package:taffi/features/auth/providers/user_provider.dart';
import 'package:taffi/features/specialties/providers/specialty_provider.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

void main() {
  // Initialize timezone database
  tz.initializeTimeZones();

  // Set Baghdad timezone as default
  tz.setLocalLocation(tz.getLocation('Asia/Baghdad'));

  runApp(const TaffiApp());
}

class TaffiApp extends StatelessWidget {
  const TaffiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => DoctorProvider()..getAllDoctors()),
        ChangeNotifierProvider(create: (context) => SpecialtyProvider()..getSpecialties()),
        ChangeNotifierProvider(create: (context) => UserProvider()..getUserInfo()),
        ChangeNotifierProvider(create: (context) => AppointmentProvider()..getAppointments()),
      ],
      child: MaterialApp(
        title: 'Taffi',
        theme: AppTheme.lightTheme,
        debugShowCheckedModeBanner: false,
        builder: (context, child) {
          return Directionality(textDirection: TextDirection.rtl, child: child!);
        },
        initialRoute: RouteNames.splash,
        onGenerateRoute: AppRouter.generateRoute,
        navigatorKey: NavigationService().navigatorKey,
      ),
    );
  }
}
