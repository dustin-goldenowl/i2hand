import 'package:flutter/material.dart';
import 'package:i2hand/src/theme/colors.dart';
import 'package:i2hand/src/theme/value.dart';

class XFillButton extends StatelessWidget {
  const XFillButton(
      {super.key,
      required this.label,
      this.bgColor = AppColors.primary,
      this.onPressed,
      this.isLoading = false,
      this.borderRadius = AppRadius.r8,
      this.circularColor = AppColors.white,
      this.aligmentRowLabel = MainAxisAlignment.center,
      this.padding,
      this.border});
  final Widget label;
  final Color bgColor;
  final double borderRadius;
  final BorderSide? border;
  final void Function()? onPressed;
  final bool isLoading;
  final Color circularColor;
  final MainAxisAlignment aligmentRowLabel;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        surfaceTintColor: MaterialStateProperty.all(Colors.transparent),
        shape: MaterialStateProperty.all(RoundedRectangleBorder(
            side: border ?? BorderSide.none,
            borderRadius: BorderRadius.circular(borderRadius))),
        backgroundColor: MaterialStateProperty.all(bgColor),
        padding: MaterialStatePropertyAll(padding),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: aligmentRowLabel,
        children: [
          isLoading
              ? SizedBox(
                  width: AppSize.s20,
                  height: AppSize.s20,
                  child: CircularProgressIndicator(
                    color: circularColor,
                    strokeWidth: AppSize.s2,
                  ),
                )
              : label
        ],
      ),
    );
  }
}
