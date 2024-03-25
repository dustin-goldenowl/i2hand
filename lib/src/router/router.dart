import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:i2hand/src/feature/add_product/logic/add_product_bloc.dart';
import 'package:i2hand/src/feature/add_product/view/post_new_product_screen.dart';
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
import 'package:i2hand/src/feature/payment/view/payment_screen.dart';
import 'package:i2hand/src/feature/product/logic/detail_product_bloc.dart';
import 'package:i2hand/src/feature/product/view/detail_product_screen.dart';
import 'package:i2hand/src/feature/setting/feature/detail_account/logic/detail_account_bloc.dart';
import 'package:i2hand/src/feature/setting/feature/detail_account/view/detail_account_screen.dart';
import 'package:i2hand/src/feature/setting/view/setting_screen.dart';
import 'package:i2hand/src/feature/profile/view/profile_screen.dart';
import 'package:i2hand/src/feature/recently_viewed/logic/recently_viewed_bloc.dart';
import 'package:i2hand/src/feature/recently_viewed/view/recently_viewed_screen.dart';
import 'package:i2hand/src/feature/syncing_data/view/syncing_data_screen.dart';
import 'package:i2hand/src/feature/wishlist/logic/wishlist_bloc.dart';
import 'package:i2hand/src/feature/wishlist/view/wishlist_screen.dart';
import 'package:i2hand/src/network/model/user/user.dart';
import 'package:i2hand/src/router/coordinator.dart';
import 'package:i2hand/src/router/route_name.dart';
import 'package:i2hand/src/service/shared_pref.dart';
import 'package:i2hand/widget/page/select_page.dart';

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
      GoRoute(
          parentNavigatorKey: AppCoordinator.navigatorKey,
          name: AppRouteNames.payment.name,
          path: AppRouteNames.payment.buildPathParam,
          builder: (__, state) {
            final productId = state.pathParameters[AppRouteNames.payment.param]!;
            return BlocProvider(
              create: (context) => DetailProductBloc(productId),
              child: const PaymentScreen(),
            );
          }),
      GoRoute(
        parentNavigatorKey: AppCoordinator.navigatorKey,
        name: AppRouteNames.newPost.name,
        path: AppRouteNames.newPost.buildPathParam,
        builder: (__, state) {
          final category = state.pathParameters[AppRouteNames.newPost.param]!;
          return BlocProvider(
            create: (context) => AddProductBloc(category),
            child: const PostNewProductScreen(),
          );
        },
      ),
      GoRoute(
        parentNavigatorKey: AppCoordinator.navigatorKey,
        name: AppRouteNames.selectAttribute.name,
        path: AppRouteNames.selectAttribute.buildPath2Param,
        builder: (_, state) {
          final attributeName =
              state.pathParameters[AppRouteNames.selectAttribute.param]!;
          final selectedValue =
              state.pathParameters[AppRouteNames.selectAttribute.param2]!;
          return XSelectPage(
            currentValue: selectedValue,
            attributeName: attributeName,
          );
        },
      ),
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
                    path: AppRouteNames.search.buildSubPathParam,
                    builder: (__, state) {
                      final options =
                          state.pathParameters[AppRouteNames.search.param]!;
                      return BlocProvider(
                        create: (context) => SearchBloc(),
                        child: SearchScreen(
                          options: options,
                        ),
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
              ]),
          GoRoute(
            path: AppRouteNames.wishlist.path,
            name: AppRouteNames.wishlist.name,
            pageBuilder: (context, state) => NoTransitionPage(
              child: BlocProvider(
                create: (context) => WishlistBloc(),
                child: const WishlistScreen(),
              ),
            ),
          ),
          GoRoute(
            path: AppRouteNames.recentlyViewed.path,
            name: AppRouteNames.recentlyViewed.name,
            pageBuilder: (context, state) => NoTransitionPage(
              child: BlocProvider(
                create: (context) => RecentlyViewedBloc(),
                child: const RecentlyViewedScreen(),
              ),
            ),
          ),
          GoRoute(
              path: AppRouteNames.account.path,
              name: AppRouteNames.account.name,
              pageBuilder: (context, state) => const NoTransitionPage(
                    child: ProfileScreen(),
                  ),
              routes: [
                GoRoute(
                    parentNavigatorKey: AppCoordinator.navigatorKey,
                    name: AppRouteNames.setting.name,
                    path: AppRouteNames.setting.subPath,
                    builder: (__, _) {
                      return BlocProvider(
                        create: (context) => SearchBloc(),
                        child: const SettingScreen(),
                      );
                    },
                    routes: [
                      GoRoute(
                          parentNavigatorKey: AppCoordinator.navigatorKey,
                          name: AppRouteNames.detailAccount.name,
                          path: AppRouteNames.detailAccount.subPath,
                          builder: (__, _) {
                            var user = SharedPrefs.I.getUser();
                            var userAvatar = SharedPrefs.I.getUserAvatar();
                            final userWithAvatar = user?.copyWith(
                                avatar: userAvatar
                                    .map((e) => e.toString())
                                    .toList());
                            return BlocProvider(
                              create: (context) => DetailAccountBloc(
                                  userWithAvatar ?? MUser.empty()),
                              child: const DetailAccountScreen(),
                            );
                          }),
                    ]),
              ]),
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
