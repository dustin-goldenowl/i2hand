import 'dart:math';

import 'package:flutter/material.dart';
import 'package:i2hand/gen/assets.gen.dart';
import 'package:i2hand/package/dismiss_keyboard/dismiss_keyboard.dart';
import 'package:i2hand/src/localization/localization_utils.dart';
import 'package:i2hand/src/theme/colors.dart';
import 'package:i2hand/src/theme/styles.dart';
import 'package:i2hand/src/theme/value.dart';
import 'package:i2hand/src/utils/padding_utils.dart';
import 'package:i2hand/src/utils/string_ext.dart';
import 'package:i2hand/widget/button/fill_button.dart';
import 'package:i2hand/widget/text_field/password_field.dart';
import 'package:i2hand/widget/text_field/text_field.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.grey8,
      child: DismissKeyBoard(
        child: Stack(
          children: [
            _renderBackground(),
            _renderSignUpBody(context),
          ],
        ),
      ),
    );
  }

  Widget _renderBackground() {
    return Assets.svg.bubbles4.svg(fit: BoxFit.cover);
  }

  Widget _renderSignUpBody(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: AppPadding.p20),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              XPaddingUtils.verticalPadding(height: AppPadding.p135),
              _renderSignUpText(context),
              XPaddingUtils.verticalPadding(height: AppPadding.p20),
              _renderAddAvatar(),
              XPaddingUtils.verticalPadding(height: AppPadding.p15),
              _renderEmailField(context),
              XPaddingUtils.verticalPadding(height: AppPadding.p10),
              _renderPasswordField(context),
              XPaddingUtils.verticalPadding(height: AppPadding.p10),
              _renderConfirmPasswordField(context),
              XPaddingUtils.verticalPadding(height: AppPadding.p10),
              _renderNumberPhoneField(context),
              XPaddingUtils.verticalPadding(height: AppPadding.p20),
              _renderNextButton(context),
              XPaddingUtils.verticalPadding(height: AppPadding.p5),
              _renderOrText(context),
              XPaddingUtils.verticalPadding(height: AppPadding.p10),
              _renderSocialSignInSection(context),
              XPaddingUtils.verticalPadding(height: AppPadding.p45),
            ],
          ),
        ),
      ),
    );
  }

  Widget _renderSignUpText(BuildContext context) {
    return Text(
      S.of(context).createAccount.capitalizeEachText(),
      style: AppTextStyle.titleTextStyle.copyWith(
          fontSize: AppFontSize.f50, color: AppColors.text, height: 0.9),
    );
  }

  Widget _renderAddAvatar() {
    return Container(
      height: AppSize.s90,
      width: AppSize.s90,
      alignment: Alignment.center,
      child: Stack(
        alignment: Alignment.center,
        children: [
          const Icon(
            Icons.photo_camera_outlined,
            color: AppColors.primary,
            size: AppSize.s40,
          ),
          CustomPaint(
            size: const Size(AppSize.s90, AppSize.s90),
            foregroundPainter:
                MyPainter(completeColor: AppColors.primary, width: 2),
          ),
        ],
      ),
    );
  }

  Widget _renderEmailField(BuildContext context) {
    {
      return XTextField(
          label: S.of(context).email,
          labelStyle: AppTextStyle.labelStyle,
          radius: AppRadius.r30,
          hintText: S.of(context).email,
          onChanged: (email) {});
    }
  }

  Widget _renderPasswordField(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          S.of(context).password,
          style: AppTextStyle.labelStyle,
        ),
        XPaddingUtils.verticalPadding(height: AppPadding.p10),
        XPasswordField(
          passwordLength: 8,
          onChangedPassword: (pass) {},
          password: '',
        ),
      ],
    );
  }

  Widget _renderConfirmPasswordField(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          S.of(context).confirmPassword,
          style: AppTextStyle.labelStyle,
        ),
        XPaddingUtils.verticalPadding(height: AppPadding.p10),
        XPasswordField(
          passwordLength: 8,
          onChangedPassword: (pass) {},
          password: '',
        ),
      ],
    );
  }

  Widget _renderNumberPhoneField(BuildContext context) {
    {
      return XTextField(
          keyboardType: TextInputType.phone,
          label: S.of(context).yourNumber,
          labelStyle: AppTextStyle.labelStyle,
          radius: AppRadius.r30,
          hintText: S.of(context).yourNumber,
          onChanged: (phoneNumber) {});
    }
  }

  Widget _renderNextButton(BuildContext context) {
    return XFillButton(
      onPressed: () {},
      label: Text(
        S.of(context).done,
        style: AppTextStyle.buttonTextStylePrimary,
      ),
    );
  }

  Widget _renderSocialSignInSection(BuildContext context) {
    return _renderGGSignUp(context);
  }

  Widget _renderGGSignUp(BuildContext context) {
    return XFillButton(
        bgColor: AppColors.white,
        border: const BorderSide(color: AppColors.grey2, width: 0.5),
        borderRadius: AppRadius.r10,
        onPressed: () {},
        label: Row(
          children: [
            Assets.svg.google.svg(width: AppFontSize.f20),
            XPaddingUtils.horizontalPadding(width: AppPadding.p15),
            Text(
              S.of(context).signUpByGoogle,
            )
          ],
        ));
  }

  Widget _renderOrText(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          S.of(context).or.toUpperCase(),
          style: AppTextStyle.labelStyle,
        ),
      ],
    );
  }
}

class MyPainter extends CustomPainter {
  Color lineColor = Colors.transparent;
  Color completeColor;
  double width;
  MyPainter({required this.completeColor, required this.width});
  @override
  void paint(Canvas canvas, Size size) {
    Paint complete = Paint()
      ..color = completeColor
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = width;

    Offset center = Offset(size.width / 2, size.height / 2);
    double radius = min(size.width / 2, size.height / 2);
    var percent = (size.width * 0.001) / 2;

    double arcAngle = 2 * pi * percent;

    for (var i = 0; i < 8; i++) {
      var init = (-pi / 2) * (i / 2);

      canvas.drawArc(Rect.fromCircle(center: center, radius: radius), init,
          arcAngle, false, complete);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
