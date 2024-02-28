import 'package:awesome_bottom_bar/widgets/inspired/inspired.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i2hand/src/feature/admin/dashboard/logic/dashboard_bloc.dart';
import 'package:i2hand/src/feature/admin/dashboard/logic/dashboard_state.dart';
import 'package:i2hand/src/feature/dashboard/item/navigation_bar.dart';
import 'package:i2hand/src/theme/colors.dart';

class AdminDashBoardScreen extends StatefulWidget {
  const AdminDashBoardScreen({
    super.key,
    required this.currentItem,
    required this.body,
  });

  final XAdminNavigationBarItems currentItem;
  final Widget body;

  @override
  State<AdminDashBoardScreen> createState() => _AdminDashBoardScreenState();
}

class _AdminDashBoardScreenState extends State<AdminDashBoardScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AdminDashboardBloc(widget.currentItem),
      child: BlocBuilder<AdminDashboardBloc, XAdminNavigationBarItems>(
        builder: (context, state) {
          return PopScope(
            canPop: false,
            onPopInvoked: (didPop) async {
              context.read<AdminDashboardBloc>().goHome();
            },
            child: Scaffold(
              body: widget.body,
              bottomNavigationBar: XBottomNavigationBar(
                items: context
                    .read<AdminDashboardBloc>()
                    .getListBottomAppNavItem(),
                index: state.index,
                isFixed: false,
                fixedIndex: 0,
                style: ItemStyle.circle,
                color: AppColors.black,
                bgColor: AppColors.grey6,
                onChangedTab: (index) => context
                    .read<AdminDashboardBloc>()
                    .onDestinationSelected(index),
              ),
            ),
          );
        },
      ),
    );
  }
}
