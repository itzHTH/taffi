import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Image.asset("assets/images/doctor1.png", fit: BoxFit.contain),
            Text("Welcome to Taffi"),
          ],
        ),
      ),
    );
  }
}
