import 'package:flutter/material.dart';
import 'package:taffi/core/features/login/screen/login_screen.dart';

void main() {
  runApp(const TaffiApp());
}

class TaffiApp extends StatelessWidget {
  const TaffiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: LoginScreen());
  }
}
