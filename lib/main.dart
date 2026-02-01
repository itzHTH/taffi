import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  tz.initializeTimeZones();
  tz.setLocalLocation(tz.getLocation('Asia/Baghdad'));
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(statusBarColor: Colors.white, statusBarIconBrightness: Brightness.dark),
  );
  runApp(const TaffiApp());
}

class TaffiApp extends StatelessWidget {
  const TaffiApp({super.key});

  @override
  Widget build(BuildContext context) {
    final navigatorKey = NavigationService().navigatorKey;

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => DoctorProvider()),
        ChangeNotifierProvider(create: (context) => SpecialtyProvider()),
        ChangeNotifierProvider(create: (context) => UserProvider()),
        ChangeNotifierProvider(create: (context) => AppointmentProvider()),
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
        navigatorKey: navigatorKey,
      ),
    );
  }
}
