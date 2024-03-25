import 'package:flutter/material.dart';
import 'package:i2hand/src/theme/colors.dart';
import 'package:i2hand/src/theme/styles.dart';
import 'package:i2hand/src/theme/value.dart';

class XLabelChip extends StatelessWidget {
  const XLabelChip({
    super.key,
    required this.title,
    required this.onTap,
    this.backgroundColor = AppColors.white,
    this.textStyle,
  });
  final String title;
  final Function onTap;
  final Color backgroundColor;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Container(
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(AppRadius.r40),
        ),
        child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: AppPadding.p5,
              horizontal: AppPadding.p10,
            ),
            child: Text(
              title,
              style: textStyle ??
                  AppTextStyle.labelStyle.copyWith(
                    fontSize: AppFontSize.f15,
                    fontWeight: FontWeight.w500,
                  ),
            )),
      ),
    );
  }
}
