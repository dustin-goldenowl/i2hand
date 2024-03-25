import 'package:flutter/material.dart';
import 'package:i2hand/src/theme/colors.dart';
import 'package:i2hand/src/theme/styles.dart';
import 'package:i2hand/src/theme/value.dart';

class XRadioWithLabelButton<T> extends StatelessWidget {
  const XRadioWithLabelButton({
    super.key,
    this.width,
    required this.value,
    required this.groupValue,
    required this.label,
    required this.onTap,
    this.borderRadius = AppRadius.r16,
  });
  final T value;
  final T groupValue;
  final String label;
  final double? width;
  final double borderRadius;
  final Function(T) onTap;

  @override
  Widget build(BuildContext context) {
    final isSelected = value == groupValue;
    return GestureDetector(
      onTap: () {
        onTap.call(value);
      },
      child: Container(
        width: width,
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.backgroundButton
              : AppColors.pinkBackgroundSecondary,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: Stack(
          alignment: Alignment.centerRight,
          children: [
            Positioned(
              left: 0,
              right: 0,
              child: Text(
                label,
                textAlign: TextAlign.center,
                style: AppTextStyle.hintTextStyle.copyWith(
                    fontSize: AppFontSize.f12,
                    color: isSelected ? AppColors.primary : AppColors.black,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.w500),
              ),
            ),
            _renderRadioIcon(context, isSelected: isSelected),
          ],
        ),
      ),
    );
  }

  Widget _renderRadioIcon(BuildContext context, {required bool isSelected}) {
    return isSelected
        ? Container(
            width: AppSize.s24,
            height: AppSize.s24,
            margin: const EdgeInsets.all(AppPadding.p7),
            decoration: BoxDecoration(
                color: AppColors.primary,
                border: Border.all(color: AppColors.white, width: AppSize.s2),
                borderRadius: BorderRadius.circular(AppRadius.r12)),
            child: const Center(
                child: Icon(
              Icons.check,
              size: AppSize.s14,
              color: AppColors.white,
              opticalSize: AppSize.s3,
            )),
          )
        : Container(
            width: AppSize.s24,
            height: AppSize.s24,
            margin: const EdgeInsets.all(AppPadding.p7),
            decoration: BoxDecoration(
                color: AppColors.pinkBackground,
                border: Border.all(color: AppColors.white, width: AppSize.s2),
                borderRadius: BorderRadius.circular(AppRadius.r12)),
          );
  }
}
