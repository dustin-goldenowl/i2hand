import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';
import 'package:i2hand/src/config/constants/app_const.dart';
import 'package:i2hand/src/feature/dashboard/logic/dashboard_state.dart';
import 'package:i2hand/src/router/coordinator.dart';
import 'package:i2hand/src/utils/base_cubit.dart';

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
}
