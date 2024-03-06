import 'package:flutter/material.dart';
import 'package:i2hand/src/theme/colors.dart';
import 'package:i2hand/src/theme/value.dart';

class XCircleEmptyContainer extends StatelessWidget {
  const XCircleEmptyContainer({super.key, required this.emptyIcon});
  final Widget emptyIcon;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: AppColors.white,
      radius: AppSize.s67,
      child: emptyIcon,
    );
  }
}
