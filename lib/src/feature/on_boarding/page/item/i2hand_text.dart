import 'package:flutter/widgets.dart';
import 'package:i2hand/gen/fonts.gen.dart';
import 'package:i2hand/src/localization/localization_utils.dart';
import 'package:i2hand/src/theme/colors.dart';
import 'package:i2hand/src/theme/styles.dart';
import 'package:i2hand/src/theme/value.dart';

class XAppName extends StatelessWidget {
  const XAppName({super.key});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
          text: S.of(context).i,
          style: AppTextStyle.titleTextStyle.copyWith(
              color: AppColors.black, fontFamily: FontFamily.shrikhand),
          children: [
            TextSpan(
              text: S.of(context).two,
              style: AppTextStyle.titleTextStyle.copyWith(
                  color: AppColors.black,
                  fontFamily: FontFamily.lovelo,
                  fontSize: AppFontSize.f40),
            ),
            TextSpan(
              text: S.of(context).hand,
              style: AppTextStyle.titleTextStyle.copyWith(
                  color: AppColors.black,
                  fontFamily: FontFamily.lovelo,
                  fontWeight: FontWeight.bold,
                  fontSize: AppFontSize.f24),
            ),
          ]),
    );
  }
}
