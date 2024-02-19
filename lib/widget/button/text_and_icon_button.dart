import 'package:flutter/material.dart';
import 'package:i2hand/src/theme/colors.dart';
import 'package:i2hand/src/theme/styles.dart';
import 'package:i2hand/src/theme/value.dart';
import 'package:i2hand/src/utils/padding_utils.dart';

class XTextAndIconButton extends StatelessWidget {
  const XTextAndIconButton(
      {super.key, required this.label, this.onPressed, this.icon});
  final String label;
  final Function? onPressed;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          label,
          textAlign: TextAlign.center,
          style: AppTextStyle.textButtonTextStyle
              .copyWith(fontSize: AppFontSize.f14),
        ),
        XPaddingUtils.horizontalPadding(width: AppPadding.p5),
        IconButton.filled(
          onPressed: () => onPressed?.call(),
          icon: Icon(
            icon ?? Icons.arrow_forward,
            color: AppColors.white,
          ),
          color: AppColors.primary,
        )
      ],
    );
  }
}
