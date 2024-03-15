import 'package:flutter/material.dart';
import 'package:i2hand/src/localization/localization_utils.dart';
import 'package:i2hand/src/theme/colors.dart';
import 'package:i2hand/src/theme/styles.dart';
import 'package:i2hand/src/theme/value.dart';
import 'package:i2hand/src/utils/padding_utils.dart';
import 'package:i2hand/src/utils/string_utils.dart';

class XTextFieldInsideLabel extends StatelessWidget {
  const XTextFieldInsideLabel({
    super.key,
    required this.label,
    this.isRequired = false,
    this.hintText,
    this.textValue,
    this.maxLines = 1,
    this.hintMaxLines = 1,
    required this.onChanged,
  });
  final String label;
  final bool isRequired;
  final String? hintText;
  final String? textValue;
  final int maxLines;
  final int hintMaxLines;
  final Function(String) onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minHeight: AppSize.s60),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.black),
        borderRadius: BorderRadius.circular(AppRadius.r10),
        color: AppColors.white,
      ),
      padding: const EdgeInsets.symmetric(
        vertical: AppPadding.p6,
        horizontal: AppPadding.p12,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _renderTitleTextField(context),
          _renderTextField(context),
        ],
      ),
    );
  }

  Widget _renderTitleTextField(BuildContext context) {
    return Row(
      children: [
        Text(
          label,
          style: !StringUtils.isNullOrEmpty(textValue) ||
                  !StringUtils.isNullOrEmpty(hintText)
              ? AppTextStyle.titleTextStyle
                  .copyWith(color: AppColors.black, fontSize: AppFontSize.f10)
              : AppTextStyle.contentTexStyle,
        ),
        XPaddingUtils.horizontalPadding(width: AppPadding.p4),
        isRequired
            ? Text(
                S.of(context).isRequiredDef,
                style: AppTextStyle.contentTexStyleBold
                    .copyWith(color: AppColors.errorColor),
              )
            : const SizedBox.shrink(),
      ],
    );
  }

  Widget _renderTextField(BuildContext context) {
    return !StringUtils.isNullOrEmpty(textValue) ||
            !StringUtils.isNullOrEmpty(hintText)
        ? TextField(
            cursorColor: AppColors.primary,
            onChanged: (value) => onChanged(value),
            maxLines: maxLines,
            minLines: 1,
            decoration: InputDecoration(
              errorBorder: _getTransparentBorder(),
              enabledBorder: _getTransparentBorder(),
              border: _getTransparentBorder(),
              focusedBorder: _getTransparentBorder(),
              focusedErrorBorder: _getTransparentBorder(),
              hintStyle: AppTextStyle.contentTexStyle
                  .copyWith(fontSize: AppFontSize.f12),
              hintText: hintText,
              hintMaxLines: hintMaxLines,
            ),
          )
        : const SizedBox.shrink();
  }

  InputBorder _getTransparentBorder() {
    return InputBorder.none;
  }
}
