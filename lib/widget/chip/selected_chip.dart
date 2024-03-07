import 'package:flutter/material.dart';
import 'package:i2hand/gen/assets.gen.dart';
import 'package:i2hand/src/theme/colors.dart';
import 'package:i2hand/src/theme/styles.dart';
import 'package:i2hand/src/theme/value.dart';

class XSelectedChip extends StatelessWidget {
  const XSelectedChip({
    super.key,
    required this.title,
    required this.isSelected,
    required this.onTap,
  });
  final String title;
  final bool isSelected;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: isSelected ? AppColors.backgroundButton : AppColors.grey8,
          borderRadius: BorderRadius.circular(AppRadius.r40),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Padding(
                padding: const EdgeInsets.symmetric(vertical: AppPadding.p5),
                child: Text(
                  title,
                  style: isSelected
                      ? AppTextStyle.labelStyle.copyWith(
                          color: AppColors.primary,
                          fontSize: AppFontSize.f15,
                          fontWeight: FontWeight.bold,
                        )
                      : AppTextStyle.labelStyle.copyWith(
                          fontSize: AppFontSize.f15,
                          fontWeight: FontWeight.w500,
                        ),
                )),
            isSelected
                ? Positioned(right: 5, child: Assets.svg.check.svg())
                : const SizedBox.shrink()
          ],
        ),
      ),
    );
  }
}
