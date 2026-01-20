import 'package:flutter/material.dart';
import 'package:taffi/features/appointments/screens/appointments_screen.dart';
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
  int _currentScreen = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      initialPage: _currentScreen,
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Widget _getScreen(int index) {
    switch (index) {
      case 0:
        return const HomeScreen();
      case 1:
        return const MessagesScreen();
      case 2:
        return const AppointmentScreen();
      case 3:
        return const ProfileScreen();
      default:
        return const HomeScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: _currentScreen,
        onTap: (index) {
          _pageController.animateToPage(
            index,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        },
      ),
      body: PageView.builder(
        itemBuilder: (context, index) => _getScreen(index),
        itemCount: 4,
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _currentScreen = index;
          });
        },
        physics: const BouncingScrollPhysics(),
      ),
    );
  }
}
