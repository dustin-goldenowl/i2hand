import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:i2hand/src/feature/admin/dashboard/logic/dashboard_state.dart';
import 'package:i2hand/src/feature/admin/dashboard/view/admin_dashboard_screen.dart';
import 'package:i2hand/src/feature/admin/home/logic/admin_home_bloc.dart';
import 'package:i2hand/src/feature/admin/home/view/admin_home.dart';
import 'package:i2hand/src/feature/authentication/forgot_password/logic/reset_password_bloc.dart';
import 'package:i2hand/src/feature/authentication/forgot_password/view/reset_password_screen.dart';
import 'package:i2hand/src/feature/authentication/forgot_password/view/send_mail_success_screen.dart';
import 'package:i2hand/src/feature/authentication/sign_in/logic/sign_in_bloc.dart';
import 'package:i2hand/src/feature/authentication/sign_in/view/enter_password_screen.dart';
import 'package:i2hand/src/feature/authentication/sign_in/view/sign_in_screen.dart';
import 'package:i2hand/src/feature/authentication/sign_up/logic/sign_up_bloc.dart';
import 'package:i2hand/src/feature/authentication/sign_up/view/sign_up_screen.dart';
import 'package:i2hand/src/feature/authentication/start/view/start_screen.dart';
import 'package:i2hand/src/feature/cart/logic/cart_bloc.dart';
import 'package:i2hand/src/feature/cart/logic/select_location_bloc.dart';
import 'package:i2hand/src/feature/cart/view/cart_screen.dart';
import 'package:i2hand/src/feature/cart/widget/select_location_page.dart';
import 'package:i2hand/src/feature/dashboard/logic/dashboard_state.dart';
import 'package:i2hand/src/feature/dashboard/view/dash_board_screen.dart';
import 'package:i2hand/src/feature/home/feature/search/logic/search_bloc.dart';
import 'package:i2hand/src/feature/home/feature/search/view/search_screen.dart';
import 'package:i2hand/src/feature/home/logic/home_bloc.dart';
import 'package:i2hand/src/feature/home/view/home_screen.dart';
import 'package:i2hand/src/feature/on_boarding/on_boarding_screen.dart';
import 'package:i2hand/src/feature/product/logic/detail_product_bloc.dart';
import 'package:i2hand/src/feature/product/view/detail_product_screen.dart';
import 'package:i2hand/src/feature/syncing_data/view/syncing_data_screen.dart';
import 'package:i2hand/src/network/model/user/user.dart';
import 'package:i2hand/src/router/coordinator.dart';
import 'package:i2hand/src/router/route_name.dart';
import 'package:i2hand/src/service/shared_pref.dart';

class AppRouter {
  final router = GoRouter(
    navigatorKey: AppCoordinator.navigatorKey,
    initialLocation: AppRouteNames.syncingData.path,
    debugLogDiagnostics: kDebugMode,
    routes: <RouteBase>[
      GoRoute(
        parentNavigatorKey: AppCoordinator.navigatorKey,
        name: AppRouteNames.onBoarding.name,
        path: AppRouteNames.onBoarding.path,
        builder: (_, __) => const OnBoardingScreen(),
      ),
      GoRoute(
        parentNavigatorKey: AppCoordinator.navigatorKey,
        name: AppRouteNames.syncingData.name,
        path: AppRouteNames.syncingData.path,
        builder: (_, __) => const SyncDataScreen(),
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
                    routes: [
                      GoRoute(
                        parentNavigatorKey: AppCoordinator.navigatorKey,
                        name: AppRouteNames.forgotPassword.name,
                        path: AppRouteNames.forgotPassword.subPath,
                        builder: (_, __) {
                          return BlocProvider(
                            create: (context) {
                              final user = SharedPrefs.I.getUser();
                              return ResetPasswordBloc(user ?? MUser.empty());
                            },
                            child: const ResetPasswordScreen(),
                          );
                        },
                        routes: [
                          GoRoute(
                            parentNavigatorKey: AppCoordinator.navigatorKey,
                            name: AppRouteNames.sendMailSuccess.name,
                            path: AppRouteNames.sendMailSuccess.subPath,
                            builder: (_, __) {
                              return BlocProvider(
                                create: (context) {
                                  final user = SharedPrefs.I.getUser();
                                  return ResetPasswordBloc(
                                      user ?? MUser.empty());
                                },
                                child: const SendMailSuccessScreen(),
                              );
                            },
                          )
                        ],
                      )
                    ],
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
          ]),
      GoRoute(
          parentNavigatorKey: AppCoordinator.navigatorKey,
          name: AppRouteNames.productDetail.name,
          path: AppRouteNames.productDetail.buildPathParam,
          builder: (__, state) {
            final id = state.pathParameters[AppRouteNames.productDetail.param]!;
            return BlocProvider(
              create: (context) => DetailProductBloc(id),
              child: const ProductDetailScreen(),
            );
          }),
      ShellRoute(
        navigatorKey: AppCoordinator.shellKey,
        builder: (context, state, child) => DashBoardScreen(
          currentItem: XNavigationBarItems.fromLocation(state.uri.toString()),
          body: child,
        ),
        routes: <RouteBase>[
          GoRoute(
              path: AppRouteNames.home.path,
              name: AppRouteNames.home.name,
              pageBuilder: (context, state) => NoTransitionPage(
                    child: BlocProvider(
                      create: (context) => HomeBloc(),
                      child: const HomeScreen(),
                    ),
                  ),
              routes: [
                GoRoute(
                    parentNavigatorKey: AppCoordinator.navigatorKey,
                    name: AppRouteNames.search.name,
                    path: AppRouteNames.search.subPath,
                    builder: (__, _) {
                      return BlocProvider(
                        create: (context) => SearchBloc(),
                        child: const SearchScreen(),
                      );
                    }),
              ]),
          GoRoute(
              path: AppRouteNames.cart.path,
              name: AppRouteNames.cart.name,
              pageBuilder: (context, state) => NoTransitionPage(
                    child: BlocProvider(
                      create: (context) => CartBloc(),
                      child: const CartScreen(),
                    ),
                  ),
              routes: [
                GoRoute(
                    parentNavigatorKey: AppCoordinator.navigatorKey,
                    name: AppRouteNames.selectLocation.name,
                    path: AppRouteNames.selectLocation.buildSubPathParam,
                    builder: (__, state) {
                      final address = state
                          .pathParameters[AppRouteNames.selectLocation.param]!;
                      return BlocProvider(
                        create: (context) => SelectLocationBloc(address),
                        child: const XSelectLocationPage(),
                      );
                    }),
              ])
        ],
      ),
      ShellRoute(
        navigatorKey: AppCoordinator.shellKey,
        builder: (context, state, child) => AdminDashBoardScreen(
          currentItem:
              XAdminNavigationBarItems.fromLocation(state.uri.toString()),
          body: child,
        ),
        routes: <RouteBase>[
          GoRoute(
            path: AppRouteNames.adminHome.path,
            name: AppRouteNames.adminHome.name,
            pageBuilder: (context, state) => NoTransitionPage(
              child: BlocProvider(
                create: (context) => AdminHomeBloc(),
                child: const AdminHomeScreen(),
              ),
            ),
          )
        ],
      ),
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
