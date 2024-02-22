import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';
import 'package:awesome_bottom_bar/widgets/inspired/inspired.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i2hand/src/feature/dashboard/logic/dashboard_bloc.dart';
import 'package:i2hand/src/feature/dashboard/logic/dashboard_state.dart';
import 'package:i2hand/src/theme/colors.dart';
import 'package:i2hand/src/theme/decorations.dart';

class XBottomNavigationBar extends StatelessWidget {
  final List<TabItem> items;
  final Color? bgColor;
  final Color? color;
  final int index;
  final ItemStyle style;
  final Function(int) onChangedTab;
  const XBottomNavigationBar(
      {super.key,
      required this.items,
      this.bgColor,
      this.color,
      this.index = 0,
      required this.style,
      required this.onChangedTab});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardBloc, XNavigationBarItems>(
      builder: (context, state) {
        return BottomBarInspiredOutside(
          items: items,
          fixed: true,
          fixedIndex: 2,
          backgroundColor: bgColor ?? AppColors.white,
          color: color ?? AppColors.red,
          colorSelected: Colors.white,
          indexSelected: index,
          boxShadow: AppDecorations.shadow,
          onTap: (int index) => onChangedTab(index),
          top: -28,
          animated: false,
          itemStyle: ItemStyle.circle,
          chipStyle: const ChipStyle(
              notchSmoothness: NotchSmoothness.smoothEdge,
              background: AppColors.secondPrimary),
        );
      },
    );
  }
}
