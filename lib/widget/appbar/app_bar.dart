import 'package:flutter/material.dart';
import 'package:i2hand/src/theme/colors.dart';
import 'package:i2hand/src/theme/styles.dart';
import 'package:i2hand/src/theme/value.dart';
import 'package:i2hand/src/utils/padding_utils.dart';
import 'package:i2hand/src/utils/string_utils.dart';

class XAppBar extends StatelessWidget {
  const XAppBar({
    super.key,
    this.titlePage,
    this.actions,
    this.fontColor,
    this.leading,
    this.subTitlePage,
  });
  final String? titlePage;
  final String? subTitlePage;
  final Widget? leading;
  final Widget? actions;
  final Color? fontColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppPadding.p20,
        vertical: AppPadding.p12,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _renderTitle(context),
          _renderSubTitle(context),
        ],
      ),
    );
  }

  Widget _renderTitle(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisSize: MainAxisSize.max,
      children: [
        (leading == null) ? const SizedBox.shrink() : leading!,
        StringUtils.isNullOrEmpty(titlePage)
            ? const SizedBox.shrink()
            : Text(
                titlePage!,
                style: AppTextStyle.titleTextStyle.copyWith(
                  fontSize: AppFontSize.f28,
                  color: fontColor,
                ),
              ),
        XPaddingUtils.horizontalPadding(width: AppPadding.p20),
        Expanded(child: actions ?? const SizedBox.shrink()),
      ],
    );
  }

  Widget _renderSubTitle(BuildContext context) {
    return StringUtils.isNullOrEmpty(subTitlePage)
        ? const SizedBox.shrink()
        : Text(
            subTitlePage!,
            style: AppTextStyle.hintTextStyle.copyWith(
              color: AppColors.black2,
              fontSize: AppSize.s16,
            ),
          );
  }
}
