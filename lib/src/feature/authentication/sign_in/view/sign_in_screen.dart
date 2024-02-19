import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i2hand/gen/assets.gen.dart';
import 'package:i2hand/package/dismiss_keyboard/dismiss_keyboard.dart';
import 'package:i2hand/src/dialog/toast_wrapper.dart';
import 'package:i2hand/src/feature/authentication/sign_in/logic/sign_in_bloc.dart';
import 'package:i2hand/src/feature/authentication/sign_in/logic/sign_in_state.dart';
import 'package:i2hand/src/localization/localization_utils.dart';
import 'package:i2hand/src/router/coordinator.dart';
import 'package:i2hand/src/theme/colors.dart';
import 'package:i2hand/src/theme/styles.dart';
import 'package:i2hand/src/theme/value.dart';
import 'package:i2hand/src/utils/padding_utils.dart';
import 'package:i2hand/src/utils/string_utils.dart';
import 'package:i2hand/widget/button/fill_button.dart';
import 'package:i2hand/widget/text_field/text_field.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.grey8,
      child: DismissKeyBoard(
        child: Stack(
          children: [
            _renderBackground(),
            _renderSignInBody(context),
          ],
        ),
      ),
    );
  }

  Widget _renderBackground() {
    return Assets.svg.bubbles1.svg(fit: BoxFit.cover);
  }

  Widget _renderSignInBody(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: AppPadding.p20),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _renderLoginText(context),
              XPaddingUtils.verticalPadding(height: AppPadding.p5),
              _renderSubTitle(context),
              XPaddingUtils.verticalPadding(height: AppPadding.p15),
              _renderEmailField(context),
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

  Widget _renderLoginText(BuildContext context) {
    return Text(
      S.of(context).login,
      style: AppTextStyle.titleTextStyle.copyWith(fontSize: AppFontSize.f52),
    );
  }

  Widget _renderSubTitle(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          S.of(context).goodToSeeYouBack,
          style: AppTextStyle.contentTexStyle
              .copyWith(fontSize: AppFontSize.f18, color: AppColors.text),
        ),
        XPaddingUtils.horizontalPadding(width: AppPadding.p5),
        const Icon(
          Icons.favorite,
          color: AppColors.text,
          size: AppFontSize.f18,
        )
      ],
    );
  }

  Widget _renderEmailField(BuildContext context) {
    return BlocBuilder<SignInBloc, SignInState>(
      buildWhen: (previous, current) =>
          previous.email != current.email ||
          previous.emailValidated != current.emailValidated,
      builder: (context, state) {
        return XTextField(
            radius: AppRadius.r30,
            errorText: StringUtils.isNullOrEmpty(state.emailValidated)
                ? null
                : state.emailValidated,
            hintText: S.of(context).email,
            onChanged: (email) {
              context.read<SignInBloc>().onChangedEmail(email);
            });
      },
    );
  }

  Widget _renderNextButton(BuildContext context) {
    return BlocListener<SignInBloc, SignInState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        switch (state.status) {
          case SignInStatus.signingIn:
            XToast.showLoading();
            return;
          case SignInStatus.successed:
            if (XToast.isShowLoading) XToast.hideLoading();
            AppCoordinator.showSignInPassScreen();
            return;
          case SignInStatus.failed:
            if (XToast.isShowLoading) XToast.hideLoading();
            XToast.error(S.of(context).someThingWentWrong);
            return;
          default:
            if (XToast.isShowLoading) XToast.hideLoading();
        }
      },
      child: XFillButton(
        onPressed: () {
          context.read<SignInBloc>().checkEmailIsValidInServer(context);
        },
        label: Text(
          S.of(context).next,
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
}
