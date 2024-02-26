import 'package:flutter/material.dart';
import 'package:i2hand/src/theme/styles.dart';
import 'package:i2hand/src/theme/value.dart';
import 'package:i2hand/src/utils/padding_utils.dart';

class XAppBar extends StatelessWidget {
  const XAppBar({super.key, required this.titlePage, this.actions});
  final String titlePage;
  final Widget? actions;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppPadding.p20,
        vertical: AppPadding.p12,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisSize: MainAxisSize.max,
        children: [
          Text(
            titlePage,
            style: AppTextStyle.titleTextStyle.copyWith(
              fontSize: AppFontSize.f28,
            ),
          ),
          XPaddingUtils.horizontalPadding(width: AppPadding.p20),
          Expanded(child: actions ?? const SizedBox.shrink()),
        ],
      ),
    );
  }
}
