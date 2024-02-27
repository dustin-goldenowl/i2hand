import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';
import 'package:awesome_bottom_bar/widgets/inspired/inspired.dart';
import 'package:flutter/material.dart';
import 'package:i2hand/src/theme/colors.dart';
import 'package:i2hand/src/theme/decorations.dart';

class XBottomNavigationBar extends StatelessWidget {
  final List<TabItem> items;
  final Color? bgColor;
  final Color? color;
  final int index;
  final ItemStyle style;
  final Function(int) onChangedTab;
  final int? fixedIndex;
  final bool isFixed;
  const XBottomNavigationBar(
      {super.key,
      required this.items,
      this.bgColor,
      this.color,
      this.index = 0,
      this.fixedIndex = 2,
      required this.style,
      this.isFixed = true,
      required this.onChangedTab});

  @override
  Widget build(BuildContext context) {
    return BottomBarInspiredOutside(
      items: items,
      fixed: isFixed,
      fixedIndex: fixedIndex,
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
  }
}
