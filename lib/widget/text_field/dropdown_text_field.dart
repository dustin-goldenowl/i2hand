import 'package:flutter/material.dart';
import 'package:i2hand/src/localization/localization_utils.dart';
import 'package:i2hand/src/theme/colors.dart';
import 'package:i2hand/src/theme/styles.dart';
import 'package:i2hand/src/theme/value.dart';
import 'package:i2hand/src/utils/padding_utils.dart';
import 'package:i2hand/src/utils/string_utils.dart';

class XDropdownTextField extends StatelessWidget {
  const XDropdownTextField({
    super.key,
    required this.label,
    this.isRequired = false,
    this.value,
    this.onTap,
  });
  final String label;
  final String? value;
  final bool isRequired;
  final Function? onTap;

  @override
  Widget build(BuildContext context) {
    final isHasValue = !StringUtils.isNullOrEmpty(value);
    return GestureDetector(
      onTap: () => onTap?.call(),
      child: Container(
        constraints: const BoxConstraints(minHeight: AppSize.s60),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppRadius.r8),
          border: Border.all(
            color: AppColors.grey4,
          ),
        ),
        padding: const EdgeInsets.symmetric(
            horizontal: AppPadding.p15, vertical: AppPadding.p6),
        child: Row(
          children: [
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _renderLabel(
                  context,
                  label: label,
                  isRequired: isRequired,
                  isHasValue: isHasValue,
                ),
                _renderValueText(isHasValue: isHasValue),
              ],
            )),
            const Icon(Icons.arrow_drop_down_outlined),
          ],
        ),
      ),
    );
  }

  Widget _renderLabel(BuildContext context,
      {required String label,
      bool isRequired = false,
      required bool isHasValue}) {
    return Row(
      children: [
        Text(
          label,
          style: isHasValue
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

  Widget _renderValueText({required bool isHasValue}) {
    return isHasValue
        ? Text(
            value!,
            style: AppTextStyle.contentTexStyle.copyWith(
              color: AppColors.black,
            ),
          )
        : const SizedBox.shrink();
  }
}
