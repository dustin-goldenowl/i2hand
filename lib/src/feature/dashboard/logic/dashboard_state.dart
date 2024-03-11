import 'package:i2hand/src/router/route_name.dart';

enum XNavigationBarItems {
  home(
    route: AppRouteNames.home,
  ),
  product(
    route: AppRouteNames.wishlist,
  ),
  post(
    route: AppRouteNames.post,
  ),
  cart(
    route: AppRouteNames.cart,
  ),
  account(
    route: AppRouteNames.account,
  );

  const XNavigationBarItems({
    required this.route,
  });

  final AppRouteNames route;

  static XNavigationBarItems fromLocation(String location) {
    if (location == XNavigationBarItems.home.route.name) {
      return XNavigationBarItems.home;
    }

    return XNavigationBarItems.home;
  }
}
