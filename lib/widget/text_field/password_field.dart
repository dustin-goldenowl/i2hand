import 'package:flutter/material.dart';
import 'package:i2hand/src/theme/colors.dart';
import 'package:i2hand/src/theme/value.dart';

class XPasswordField extends StatefulWidget {
  const XPasswordField({super.key, required this.passwordLength});
  final int passwordLength;

  @override
  State<XPasswordField> createState() => _XPasswordFieldState();
}

class _XPasswordFieldState extends State<XPasswordField> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [for (int i = 0; i < widget.passwordLength; i++) _renderCell()],
    );
  }

  Widget _renderCell() {
    return Container(
      height: AppSize.s17,
      width: AppSize.s17,
      margin: const EdgeInsets.symmetric(horizontal: AppMargin.m8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSize.s17 / 2),
        color: AppColors.backgroundButton,
      ),
    );
  }
}
