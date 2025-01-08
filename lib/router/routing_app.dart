import 'package:flutter/material.dart';
import 'package:smart_farm_application/page/home/compare_screen.dart';
import 'package:smart_farm_application/services/auth_services.dart';

import '../page/home/navigation_screen.dart';

class CustomPageRoute extends PageRouteBuilder {
  final Widget child;

  CustomPageRoute({required this.child})
      : super(
          pageBuilder: (context, animation, secondaryAnimation) => child,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(1.0, 0.0);
            const end = Offset.zero;
            const curve = Curves.easeInOut;
            var tween =
                Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
            var offsetAnimation = animation.drive(tween);

            return SlideTransition(
              position: offsetAnimation,
              child: child,
            );
          },
          transitionDuration: const Duration(milliseconds: 300),
        );
}

class AppRouter {
  static const String onboarding = '/';
  static const String navigation = '/navigation';
  static const String home = '/home';
  static const String product = '/product';
  static const String compare = '/compare';

  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case onboarding:
        return CustomPageRoute(child: const AuthWidget());
      case navigation:
        return CustomPageRoute(child: const NavigationScreen());
      case compare:
        return CustomPageRoute(child: const CompareScreen());
      default:
        // if (settings.name?.startsWith('$product/') ?? false) {
        //   final productId = settings.name!.split('/')[2];
        //   return CustomPageRoute(child: ProductScreen(productId: productId));
        // }
        // return CustomPageRoute(child: NotFoundScreen());
        return CustomPageRoute(child: const AuthWidget());
    }
  }

  // For different animation types
  static Route fadeTransition(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(opacity: animation, child: child);
      },
    );
  }

  static Route scaleTransition(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return ScaleTransition(
          scale: animation,
          child: child,
        );
      },
    );
  }

  // static String getInitialRoute() {
  //   bool hasAccessToken = false;
  //   String accessToken = PreferenceUtils.getString("access_token", '');
  //   if (!StringUtils.isNullOrEmpty(accessToken)) {
  //     hasAccessToken = true;
  //   }
  //   return hasAccessToken ? ACTIVITY : ONBOARDING;
  // }
}
