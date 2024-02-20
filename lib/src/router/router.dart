import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:i2hand/src/feature/on_boarding/on_boarding_screen.dart';
import 'package:i2hand/src/router/coordinator.dart';
import 'package:i2hand/src/router/route_name.dart';

class AppRouter {
  final router = GoRouter(
    navigatorKey: AppCoordinator.navigatorKey,
    initialLocation: AppRouteNames.home.path,
    debugLogDiagnostics: kDebugMode,
    routes: <RouteBase>[
      GoRoute(
        parentNavigatorKey: AppCoordinator.navigatorKey,
        name: AppRouteNames.home.name,
        path: AppRouteNames.home.path,
        builder: (_, __) => const OnBoardingScreen(),
      )
    ],
    errorBuilder: (_, __) => Container(),
  );

  // static String _initalPath() {
  //   final userPref = UserPrefs.I.getIsFirstOpenApp();
  //   if (userPref) {
  //     UserPrefs.I.setIsFirstOpenApp(false);
  //     return AppRouteNames.onBoarding.path;
  //   }
  //   return AppRouteNames.syncData.path;
  // }
}
