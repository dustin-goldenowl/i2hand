import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';
import 'package:i2hand/src/config/constants/app_const.dart';
import 'package:i2hand/src/feature/admin/dashboard/logic/dashboard_state.dart';
import 'package:i2hand/src/router/coordinator.dart';
import 'package:i2hand/src/utils/base_cubit.dart';

class AdminDashboardBloc extends BaseCubit<XAdminNavigationBarItems> {
  AdminDashboardBloc(super.current);

  void onDestinationSelected(int index) {
    emit(XAdminNavigationBarItems.values[index]);
    AppCoordinator.goNamed(state.route.name);
  }

  void goHome() {
    emit(XAdminNavigationBarItems.adminHome);
    AppCoordinator.goNamed(state.route.name);
  }

  List<TabItem> getListBottomAppNavItem() {
    List<TabItem> listItems = [];
    for (int i = 0;
        i < AppConstantData.listDefaultAdminBottomBarItems.length;
        i++) {
      listItems.add(state.index == i
          ? AppConstantData.listSelectedAdminBottomBarItems[i]
          : AppConstantData.listDefaultAdminBottomBarItems[i]);
    }
    return listItems;
  }
}
