import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i2hand/src/feature/dashboard/logic/dashboard_state.dart';
import 'package:i2hand/src/router/coordinator.dart';

class DashboardBloc extends Cubit<XNavigationBarItems> {
  DashboardBloc(super.current);

  void onDestinationSelected(int index) {
    emit(XNavigationBarItems.values[index]);
    AppCoordinator.goNamed(state.route.name);
  }

  void goHome() {
    emit(XNavigationBarItems.home);
    AppCoordinator.goNamed(state.route.name);
  }
}
