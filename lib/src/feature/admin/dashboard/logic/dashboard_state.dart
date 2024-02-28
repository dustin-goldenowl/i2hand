import 'package:i2hand/src/router/route_name.dart';

enum XAdminNavigationBarItems {
  adminHome(
    route: AppRouteNames.adminHome,
  ),
  adminVerified(
    route: AppRouteNames.adminVerified,
  ),
  adminAccount(
    route: AppRouteNames.adminAccount,
  );

  const XAdminNavigationBarItems({
    required this.route,
  });

  final AppRouteNames route;

  static XAdminNavigationBarItems fromLocation(String location) {
    if (location == XAdminNavigationBarItems.adminHome.route.name) {
      return XAdminNavigationBarItems.adminHome;
    }

    return XAdminNavigationBarItems.adminHome;
  }
}
