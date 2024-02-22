import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:i2hand/src/feature/authentication/sign_in/logic/sign_in_bloc.dart';
import 'package:i2hand/src/feature/authentication/sign_in/view/enter_password_screen.dart';
import 'package:i2hand/src/feature/authentication/sign_in/view/sign_in_screen.dart';
import 'package:i2hand/src/feature/authentication/sign_up/logic/sign_up_bloc.dart';
import 'package:i2hand/src/feature/authentication/sign_up/view/sign_up_screen.dart';
import 'package:i2hand/src/feature/authentication/start/view/start_screen.dart';
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
      ),
      GoRoute(
          parentNavigatorKey: AppCoordinator.navigatorKey,
          name: AppRouteNames.start.name,
          path: AppRouteNames.start.path,
          builder: (_, __) => const StartScreen(),
          routes: [
            GoRoute(
                parentNavigatorKey: AppCoordinator.navigatorKey,
                name: AppRouteNames.loginEmail.name,
                path: AppRouteNames.loginEmail.subPath,
                builder: (_, __) => BlocProvider(
                      create: (context) => SignInBloc(),
                      child: const SignInScreen(),
                    ),
                routes: [
                  GoRoute(
                    parentNavigatorKey: AppCoordinator.navigatorKey,
                    name: AppRouteNames.loginPass.name,
                    path: AppRouteNames.loginPass.subPath,
                    builder: (_, __) {
                      return BlocProvider(
                        create: (context) => SignInBloc(),
                        child: const EnterPasswordScreen(),
                      );
                    },
                  )
                ]),
            GoRoute(
              parentNavigatorKey: AppCoordinator.navigatorKey,
              name: AppRouteNames.signUp.name,
              path: AppRouteNames.signUp.subPath,
              builder: (_, __) => BlocProvider(
                create: (context) => SignUpBloc(),
                child: const SignUpScreen(),
              ),
            ),
          ])
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
