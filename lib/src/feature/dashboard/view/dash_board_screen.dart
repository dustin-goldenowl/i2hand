import 'package:awesome_bottom_bar/widgets/inspired/inspired.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i2hand/src/feature/dashboard/item/navigation_bar.dart';
import 'package:i2hand/src/feature/dashboard/logic/dashboard_bloc.dart';
import 'package:i2hand/src/feature/dashboard/logic/dashboard_state.dart';
import 'package:i2hand/src/theme/colors.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({
    super.key,
    required this.currentItem,
    required this.body,
  });

  final XNavigationBarItems currentItem;
  final Widget body;

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DashboardBloc(widget.currentItem),
      child: BlocBuilder<DashboardBloc, XNavigationBarItems>(
        builder: (context, state) {
          return PopScope(
            canPop: false,
            onPopInvoked: (didPop) async {
              context.read<DashboardBloc>().goHome();
            },
            child: Scaffold(
              body: widget.body,
              bottomNavigationBar: XBottomNavigationBar(
                items: context.read<DashboardBloc>().getListBottomAppNavItem(),
                index: state.index,
                style: ItemStyle.circle,
                color: AppColors.black,
                bgColor: AppColors.grey6,
                onChangedTab: (index) =>
                    context.read<DashboardBloc>().onDestinationSelected(index),
              ),
            ),
          );
        },
      ),
    );
  }
}
