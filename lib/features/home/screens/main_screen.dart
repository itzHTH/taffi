import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:taffi/core/theme/app_colors.dart';
import 'package:taffi/features/appointment/screens/appointments_screen.dart';
import 'package:taffi/features/home/screens/home_screen.dart';
import 'package:taffi/features/home/widgets/custom_bottom_navigation_bar.dart';
import 'package:taffi/features/messages/screens/messages_screen.dart';
import 'package:taffi/features/profile/screens/profile_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final List<Widget> _screens = [
    HomeScreen(),
    MessagesScreen(),
    AppointmentScreen(),
    ProfileScreen(),
  ];
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
      body: IndexedStack(index: _currentIndex, children: _screens),
    );
  }
}
