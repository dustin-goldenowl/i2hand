import 'package:flutter/material.dart';
import 'package:i2hand/src/router/route_name.dart';

enum XNavigationBarItems {
  home(
    route: AppRouteNames.home,
    icon: Icons.view_quilt_outlined,
    selectedIcon: Icons.view_quilt,
  ),
  product(
    route: AppRouteNames.product,
    icon: Icons.calendar_month_outlined,
    selectedIcon: Icons.calendar_month,
  ),
  post(
    route: AppRouteNames.post,
    icon: Icons.calendar_month_outlined,
    selectedIcon: Icons.calendar_month,
  ),
  cart(
    route: AppRouteNames.cart,
    icon: Icons.calendar_month_outlined,
    selectedIcon: Icons.calendar_month,
  ),
  account(
    route: AppRouteNames.account,
    icon: Icons.account_circle_outlined,
    selectedIcon: Icons.account_circle,
  );

  const XNavigationBarItems({
    required this.route,
    required this.icon,
    this.selectedIcon,
  });

  final AppRouteNames route;
  final IconData icon;
  final IconData? selectedIcon;

  static XNavigationBarItems fromLocation(String location) {
    if (location == XNavigationBarItems.home.route.name) {
      return XNavigationBarItems.home;
    }

    return XNavigationBarItems.home;
  }
}
