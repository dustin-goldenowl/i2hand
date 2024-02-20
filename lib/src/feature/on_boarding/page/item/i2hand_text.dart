import 'package:flutter/widgets.dart';
import 'package:i2hand/gen/fonts.gen.dart';
import 'package:i2hand/src/localization/localization_utils.dart';
import 'package:i2hand/src/theme/colors.dart';
import 'package:i2hand/src/theme/styles.dart';
import 'package:i2hand/src/theme/value.dart';

class XAppName extends StatelessWidget {
  final Color color;
  const XAppName({super.key, this.color = AppColors.black});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
          text: S.of(context).i,
          style: AppTextStyle.titleTextStyle.copyWith(
            color: color,
            fontFamily: FontFamily.shrikhand,
            fontSize: AppFontSize.f60,
          ),
          children: [
            TextSpan(
              text: S.of(context).two,
              style: AppTextStyle.titleTextStyle.copyWith(
                  color: color,
                  fontFamily: FontFamily.raleway,
                  fontWeight: FontWeight.w900,
                  fontSize: AppFontSize.f128),
            ),
            TextSpan(
              text: S.of(context).hand.toLowerCase(),
              style: AppTextStyle.titleTextStyle.copyWith(
                  color: color,
                  fontFamily: FontFamily.raleway,
                  fontWeight: FontWeight.w900,
                  fontSize: AppFontSize.f60),
            ),
          ]),
    );
  }
}
