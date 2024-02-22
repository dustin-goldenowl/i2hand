import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:i2hand/src/router/route_name.dart';

import 'router.dart';

class AppCoordinator {
  static AppRouter get rootRouter => GetIt.I<AppRouter>();
  static final navigatorKey = GlobalKey<NavigatorState>();
  static final shellKey = GlobalKey<NavigatorState>();
  static BuildContext get context => navigatorKey.currentState!.context;

  static void pop<T extends Object?>([T? result]) => context.pop(result);

  static void goNamed(
    String name, {
    Map<String, String> params = const <String, String>{},
    Map<String, dynamic> queryParams = const <String, dynamic>{},
    Object? extra,
  }) =>
      context.goNamed(
        name,
        pathParameters: params,
        queryParameters: queryParams,
        extra: extra,
      );

  static void showHomeScreen() => context.goNamed(AppRouteNames.home.name);

  static void showStartScreen() => context.pushNamed(AppRouteNames.start.name);

  static void showSignInEmailScreen() =>
      context.pushNamed(AppRouteNames.loginEmail.name);

  static void showSignInPassScreen() =>
      context.pushNamed(AppRouteNames.loginPass.name);

  static void showResetPassScreen() =>
      context.pushNamed(AppRouteNames.forgotPassword.name);

  static void showSignUpScreen() =>
      context.pushNamed(AppRouteNames.signUp.name);

  static void showSendMailSuccess() =>
      context.pushReplacementNamed(AppRouteNames.sendMailSuccess.name);
}
