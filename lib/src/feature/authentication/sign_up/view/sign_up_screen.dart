import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i2hand/gen/assets.gen.dart';
import 'package:i2hand/package/dismiss_keyboard/dismiss_keyboard.dart';
import 'package:i2hand/src/config/constants/app_const.dart';
import 'package:i2hand/src/dialog/toast_wrapper.dart';
import 'package:i2hand/src/feature/authentication/sign_up/logic/sign_up_bloc.dart';
import 'package:i2hand/src/feature/authentication/sign_up/logic/sign_up_state.dart';
import 'package:i2hand/src/feature/common/country_logic/search_dial_code_bloc.dart';
import 'package:i2hand/src/localization/localization_utils.dart';
import 'package:i2hand/src/network/model/country/country_code.dart';
import 'package:i2hand/src/service/image_handler.dart';
import 'package:i2hand/src/theme/colors.dart';
import 'package:i2hand/src/theme/styles.dart';
import 'package:i2hand/src/theme/value.dart';
import 'package:i2hand/src/utils/padding_utils.dart';
import 'package:i2hand/src/utils/string_ext.dart';
import 'package:i2hand/src/utils/string_utils.dart';
import 'package:i2hand/src/utils/utils.dart';
import 'package:i2hand/widget/avatar/avatar.dart';
import 'package:i2hand/widget/bottomsheet/country_code_bottomsheet.dart';
import 'package:i2hand/widget/button/fill_button.dart';
import 'package:i2hand/widget/text_field/password_field.dart';
import 'package:i2hand/widget/text_field/phone_input.dart';
import 'package:i2hand/widget/text_field/text_field.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

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
              _renderAddAvatar(context),
              XPaddingUtils.verticalPadding(height: AppPadding.p15),
              _renderNameField(context),
              XPaddingUtils.verticalPadding(height: AppPadding.p10),
              _renderEmailField(context),
              XPaddingUtils.verticalPadding(height: AppPadding.p10),
              _renderPasswordField(context),
              XPaddingUtils.verticalPadding(height: AppPadding.p10),
              _renderConfirmPasswordField(context),
              XPaddingUtils.verticalPadding(height: AppPadding.p10),
              _renderNumberPhoneField(context),
              XPaddingUtils.verticalPadding(height: AppPadding.p20),
              _renderDoneButton(context),
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

  Widget _renderAddAvatar(BuildContext context) {
    return BlocSelector<SignUpBloc, SignUpState, Uint8List?>(
      selector: (state) {
        return state.avatar;
      },
      builder: (context, avatar) {
        return GestureDetector(
          onTap: () => _pickImagehandler(context, avatar),
          child: Container(
            height: AppSize.s90,
            width: AppSize.s90,
            alignment: Alignment.center,
            child: isNullOrEmpty(avatar)
                ? Stack(
                    alignment: Alignment.center,
                    children: [
                      const Icon(
                        Icons.photo_camera_outlined,
                        color: AppColors.primary,
                        size: AppSize.s40,
                      ),
                      CustomPaint(
                        size: const Size(AppSize.s90, AppSize.s90),
                        foregroundPainter: MyPainter(
                            completeColor: AppColors.primary, width: 2),
                      ),
                    ],
                  )
                : XAvatar(
                    imageType: ImageType.memory,
                    memoryData: avatar,
                  ),
          ),
        );
      },
    );
  }

  Widget _renderNameField(BuildContext context) {
    return BlocBuilder<SignUpBloc, SignUpState>(
      buildWhen: (previous, current) =>
          previous.name != current.name ||
          previous.nameValidated != current.nameValidated,
      builder: (context, state) {
        return XTextField(
            cursorColor: AppColors.primary,
            label: S.of(context).name,
            errorText: StringUtils.isNullOrEmpty(state.nameValidated)
                ? null
                : state.nameValidated,
            labelStyle: AppTextStyle.labelStyle,
            radius: AppRadius.r30,
            hintText: S.of(context).name,
            onChanged: (name) {
              context.read<SignUpBloc>().onChangedName(name);
            });
      },
    );
  }

  Widget _renderEmailField(BuildContext context) {
    return BlocBuilder<SignUpBloc, SignUpState>(
      buildWhen: (previous, current) =>
          previous.email != current.email ||
          previous.emailValidated != current.emailValidated,
      builder: (context, state) {
        return XTextField(
            cursorColor: AppColors.primary,
            label: S.of(context).email,
            errorText: StringUtils.isNullOrEmpty(state.emailValidated)
                ? null
                : state.emailValidated,
            labelStyle: AppTextStyle.labelStyle,
            radius: AppRadius.r30,
            hintText: S.of(context).email,
            onChanged: (email) {
              context.read<SignUpBloc>().onChangedEmail(email);
            });
      },
    );
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
        BlocBuilder<SignUpBloc, SignUpState>(
          buildWhen: (previous, current) =>
              previous.password != current.password ||
              previous.isWrongPassword != current.isWrongPassword,
          builder: (context, state) {
            return XPasswordField(
              passwordLength: AppConstantData.passwordLength,
              onChangedPassword: (pass) {
                context.read<SignUpBloc>().onChangedPassword(pass, context);
              },
              password: state.password,
            );
          },
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
        BlocBuilder<SignUpBloc, SignUpState>(
          buildWhen: (previous, current) =>
              previous.confirmPassword != current.confirmPassword ||
              previous.isWrongPassword != current.isWrongPassword,
          builder: (context, state) {
            return XPasswordField(
              passwordLength: AppConstantData.passwordLength,
              onChangedPassword: (pass) {
                context
                    .read<SignUpBloc>()
                    .onChangedConfirmPassword(pass, context);
              },
              isWrong: state.isWrongPassword ?? false,
              password: state.confirmPassword,
            );
          },
        ),
      ],
    );
  }

  Widget _renderNumberPhoneField(BuildContext context) {
    {
      return BlocBuilder<SignUpBloc, SignUpState>(
        buildWhen: (previous, current) =>
            previous.phone != current.phone ||
            previous.country != current.country ||
            previous.phoneValidated != current.phoneValidated,
        builder: (context, state) {
          return XPhoneInput(
            errorText: StringUtils.isNullOrEmpty(state.phoneValidated)
                ? null
                : state.phoneValidated,
            countryCodeDomain: state.country ?? CountryCode(),
            label: S.of(context).yourNumber,
            hintText: S.of(context).yourNumber,
            onPressCountryFlag: () => _onPressCountryFlag(context),
            onChangedInput: (value) =>
                context.read<SignUpBloc>().onChangedPhoneNumber(value),
          );
        },
      );
    }
  }

  Widget _renderDoneButton(BuildContext context) {
    return BlocListener<SignUpBloc, SignUpState>(
      listener: (context, state) {
        switch (state.status) {
          case SignUpStatus.signingIn:
            XToast.showLoading();
            break;
          case SignUpStatus.failed:
            if (XToast.isShowLoading) XToast.hideLoading();
            context.read<SignUpBloc>().resetStatus();
            break;
          case SignUpStatus.successed:
            if (XToast.isShowLoading) XToast.hideLoading();
            XToast.success(S.of(context).createAccount);
            context.read<SignUpBloc>().resetStatus();
            break;
          default:
            if (XToast.isShowLoading) XToast.hideLoading();
            break;
        }
      },
      child: XFillButton(
        onPressed: () async {
          context.read<SignUpBloc>().signupWithEmail(context);
        },
        label: Text(
          S.of(context).done,
          style: AppTextStyle.buttonTextStylePrimary,
        ),
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

  void _onPressCountryFlag(BuildContext context) {
    if (Platform.isIOS) {
      showCupertinoModalBottomSheet(
        duration: const Duration(milliseconds: 350),
        animationCurve: Curves.easeOut,
        enableDrag: false,
        context: context,
        topRadius: const Radius.circular(AppRadius.r16),
        builder: (context) => BlocProvider.value(
          value: context.read<SignUpBloc>(),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: searchDialCodeProvider(
              onCountrySelected: (value) =>
                  context.read<SignUpBloc>().setCountryCode(value),
            ),
          ),
        ),
        isDismissible: false,
        barrierColor: Colors.black.withOpacity(0.5),
      );
    } else {
      showMaterialModalBottomSheet(
        duration: const Duration(milliseconds: 350),
        animationCurve: Curves.easeOut,
        expand: true,
        enableDrag: false,
        context: context,
        builder: (context) => Scaffold(
          backgroundColor: Colors.transparent,
          body: searchDialCodeProvider(
            onCountrySelected: (value) {},
          ),
        ),
        isDismissible: false,
      ).then((value) {
        if (isNullOrEmpty(value)) return;
        context.read<SignUpBloc>().setCountryCode(value);
      });
    }
  }

  Widget searchDialCodeProvider({
    required ValueChanged<CountryCode> onCountrySelected,
  }) {
    return BlocProvider(
      create: (_) => SearchDialCodeBloc(),
      child: SearchDialCodeBottomSheet(onCountrySelected: onCountrySelected),
    );
  }

  void _pickImagehandler(BuildContext context, Uint8List? avatar) {
    AssetHandler.pickImagehandler(context,
        image: avatar,
        setImage: (image) => context.read<SignUpBloc>().setAvatar(image));
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
