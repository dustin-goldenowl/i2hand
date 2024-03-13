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

  static void showStartScreen() => context.goNamed(AppRouteNames.start.name);

  static void showSignInEmailScreen() =>
      context.pushNamed(AppRouteNames.loginEmail.name);

  static void showSignInPassScreen() =>
      context.pushReplacementNamed(AppRouteNames.loginPass.name);

  static void showResetPassScreen() =>
      context.pushNamed(AppRouteNames.forgotPassword.name);

  static void showSignUpScreen() =>
      context.pushNamed(AppRouteNames.signUp.name);

  static void showSendMailSuccess() =>
      context.pushReplacementNamed(AppRouteNames.sendMailSuccess.name);

  static void showSyncingDataScreen() =>
      context.goNamed(AppRouteNames.syncingData.name);

  static void showAdminHomeScreen() =>
      context.goNamed(AppRouteNames.adminHome.name);

  static void showProductDetailScreen({required String id}) => context
      .pushNamed(AppRouteNames.productDetail.name, pathParameters: {'id': id});

  static void showSearchScreen() =>
      context.pushNamed(AppRouteNames.search.name);

  static Future<String?> showSelectLocationPage(
          {required String address}) async =>
      await context.pushNamed(AppRouteNames.selectLocation.name,
          pathParameters: {'address': address}).then((value) {
        return value as String?;
      });

  static void showRecentlyViewed() =>
      context.pushNamed(AppRouteNames.recentlyViewed.name);

  static void showAddNewProductScreen({required String category}) =>
      context.pushNamed(AppRouteNames.newPost.name,
          pathParameters: {'category': category});

  static Future<String?> showSelectedAttributeValueScreen(
          {required String attributeName,
          required String selectedValue}) async =>
      await context
          .pushNamed(AppRouteNames.selectAttribute.name, pathParameters: {
        'attribute': attributeName,
        'selectedValue': selectedValue,
      }).then((value) {
        return value as String?;
      });

  static void showSettingScreen() =>
      context.pushNamed(AppRouteNames.setting.name);

  static void showDetailAccountScreen() =>
      context.pushNamed(AppRouteNames.detailAccount.name);
}
