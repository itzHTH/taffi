import 'package:flutter/material.dart';
import 'package:taffi/core/routing/app_router.dart';
import 'package:taffi/core/routing/route_names.dart';
import 'package:taffi/core/services/navigation_service.dart';
import 'package:taffi/core/theme/app_theme.dart';

void main() {
  runApp(const TaffiApp());
}

class TaffiApp extends StatelessWidget {
  const TaffiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Taffi',
      theme: AppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      builder: (context, child) {
        return Directionality(textDirection: TextDirection.rtl, child: child!);
      },
      initialRoute: RouteNames.splash,
      onGenerateRoute: AppRouter.generateRoute,
      navigatorKey: NavigationService().navigatorKey,
    );
  }
}
