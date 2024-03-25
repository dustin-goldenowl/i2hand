import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:i2hand/src/config/constants/app_const.dart';
import 'package:i2hand/src/feature/dashboard/logic/dashboard_state.dart';
import 'package:i2hand/src/feature/add_product/widget/categories_bts.dart';
import 'package:i2hand/src/router/coordinator.dart';
import 'package:i2hand/src/utils/base_cubit.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class DashboardBloc extends BaseCubit<XNavigationBarItems> {
  DashboardBloc(super.current);

  void onDestinationSelected(int index) {
    emit(XNavigationBarItems.values[index]);
    AppCoordinator.goNamed(state.route.name);
  }

  void goHome() {
    emit(XNavigationBarItems.home);
    AppCoordinator.goNamed(state.route.name);
  }

  List<TabItem> getListBottomAppNavItem() {
    List<TabItem> listItems = [];
    for (int i = 0; i < AppConstantData.listDefaultBottomBarItems.length; i++) {
      listItems.add(state.index == i
          ? AppConstantData.listSelectedBottomBarItems[i]
          : AppConstantData.listDefaultBottomBarItems[i]);
    }
    return listItems;
  }

  void showListCategoriesBts(context) {
    showCupertinoModalBottomSheet(
      duration: const Duration(milliseconds: 300),
      animationCurve: Curves.easeOut,
      context: context,
      builder: (context) => const XCategoriesBottomsheet(),
      barrierColor: Colors.transparent.withOpacity(0.5),
      enableDrag: false,
    ).then((valueCallback) {
      if (valueCallback != null) {}
    });
  }
}
