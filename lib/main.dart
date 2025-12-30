import 'package:flutter/material.dart';
import 'package:taffi/core/theme/app_theme.dart';
import 'package:taffi/features/auth/screens/login_screen.dart';

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
      home: const LoginScreen(),
    );
  }
}
