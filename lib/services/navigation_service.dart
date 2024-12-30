// navigation_service.dart
import 'package:flutter/material.dart';

class NavigationService {
  static final NavigationService _instance = NavigationService._internal();
  String? _currentRoute;

  factory NavigationService() {
    return _instance;
  }

  NavigationService._internal();

  NavigatorObserver get navigatorObserver => _RouteObserver();

  String? get currentRoute => _currentRoute;

  void _updateCurrentRoute(String? route) {
    _currentRoute = route;
  }
}

class _RouteObserver extends NavigatorObserver {
  @override
  void didPush(Route route, Route? previousRoute) {
    super.didPush(route, previousRoute);
    if (_isDialogRoute(route)) return;
    NavigationService()._updateCurrentRoute(route.settings.name);
    print('Pushed to ${route.settings.name}');
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    super.didPop(route, previousRoute);
    if (_isDialogRoute(route)) return;
    NavigationService()._updateCurrentRoute(previousRoute?.settings.name);
    print('Popped from ${route.settings.name}');
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    if (_isDialogRoute(newRoute)) return;
    NavigationService()._updateCurrentRoute(newRoute?.settings.name);
    print(
        'Replaced ${oldRoute?.settings.name} with ${newRoute?.settings.name}');
  }

  bool _isDialogRoute(Route<dynamic>? route) {
    return route?.settings.name == null;
  }
}
