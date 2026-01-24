import 'package:flutter/material.dart';

class NavigationService {
  static final NavigationService _instance = NavigationService._();

  NavigationService._();

  factory NavigationService() => _instance;

  GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  void navigateTo(String routeName, {Object? arguments}) {
    navigatorKey.currentState?.pushNamed(routeName, arguments: arguments);
  }

  Future<dynamic> pushNamedAndRemoveUntil(String routeName, {Object? arguments}) {
    return navigatorKey.currentState!.pushNamedAndRemoveUntil(
      routeName,
      (route) => false,
      arguments: arguments,
    );
  }

  void navigateBack() {
    navigatorKey.currentState?.pop();
  }
}
