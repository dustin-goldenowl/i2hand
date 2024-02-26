import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i2hand/gen/assets.gen.dart';
import 'package:i2hand/package/dismiss_keyboard/dismiss_keyboard.dart';
import 'package:i2hand/src/config/constants/app_const.dart';
import 'package:i2hand/src/dialog/toast_wrapper.dart';
import 'package:i2hand/src/feature/authentication/sign_in/logic/sign_in_bloc.dart';
import 'package:i2hand/src/feature/authentication/sign_in/logic/sign_in_state.dart';
import 'package:i2hand/src/localization/localization_utils.dart';
import 'package:i2hand/src/router/coordinator.dart';
import 'package:i2hand/src/theme/colors.dart';
import 'package:i2hand/src/theme/styles.dart';
import 'package:i2hand/src/theme/value.dart';
import 'package:i2hand/src/utils/padding_utils.dart';
import 'package:i2hand/widget/avatar/avatar.dart';
import 'package:i2hand/widget/button/text_and_icon_button.dart';
import 'package:i2hand/widget/text_field/password_field.dart';

class EnterPasswordScreen extends StatefulWidget {
  const EnterPasswordScreen({super.key});

  @override
  State<EnterPasswordScreen> createState() => _EnterPasswordScreenState();
}

class _EnterPasswordScreenState extends State<EnterPasswordScreen> {
  @override
  void initState() {
    super.initState();
    context.read<SignInBloc>().initialData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DismissKeyBoard(
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
    return Assets.svg.bubbles2.svg(fit: BoxFit.cover);
  }

  Widget _renderSignInBody(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: AppPadding.p20),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          XPaddingUtils.verticalPadding(height: AppPadding.p135),
          _renderAvatar(),
          XPaddingUtils.verticalPadding(height: AppPadding.p23),
          _renderHelloText(context),
          XPaddingUtils.verticalPadding(height: AppPadding.p23),
          _renderSubTitle(context),
          XPaddingUtils.verticalPadding(height: AppPadding.p10),
          _renderPasswordField(context),
          XPaddingUtils.verticalPadding(height: AppPadding.p20),
          _renderForgotButton(context),
          XPaddingUtils.verticalPadding(height: AppPadding.p5),
          _renderNotYouButton(context),
          XPaddingUtils.verticalPadding(height: AppPadding.p45),
        ],
      ),
    );
  }

  Widget _renderHelloText(BuildContext context) {
    return BlocBuilder<SignInBloc, SignInState>(
      buildWhen: (previous, current) => previous.user != current.user,
      builder: (context, state) {
        return DefaultTextStyle(
          style:
              AppTextStyle.titleTextStyle.copyWith(fontSize: AppFontSize.f28),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(S.of(context).hello),
              Text(state.user?.name ?? ''),
            ],
          ),
        );
      },
    );
  }

  Widget _renderSubTitle(BuildContext context) {
    return Text(
      S.of(context).typeYourPassword,
      style: AppTextStyle.contentTexStyle
          .copyWith(fontSize: AppFontSize.f18, color: AppColors.black),
    );
  }

  Widget _renderPasswordField(BuildContext context) {
    return BlocConsumer<SignInBloc, SignInState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        switch (state.status) {
          case SignInStatus.signingIn:
            XToast.showLoading();
            return;
          case SignInStatus.successed:
            if (XToast.isShowLoading) XToast.hideLoading();
            XToast.success(S.of(context).goodToSeeYouBack);            
            return;
          case SignInStatus.failed:
            if (XToast.isShowLoading) XToast.hideLoading();
            XToast.error(S.of(context).someThingWentWrong);
            return;
          default:
            if (XToast.isShowLoading) XToast.hideLoading();
        }
      },
      buildWhen: (previous, current) =>
          previous.password != current.password ||
          previous.isWrongPassword != current.isWrongPassword ||
          previous.status != current.status,
      builder: (context, state) {
        return XPasswordField(
          passwordLength: AppConstantData.passwordLength,
          isWrong: state.isWrongPassword ?? false,
          onChangedPassword: (pass) =>
              context.read<SignInBloc>().onChangedPassword(context, pass),
          password: state.password ?? '',
        );
      },
    );
  }

  Widget _renderForgotButton(BuildContext context) {
    return BlocSelector<SignInBloc, SignInState, bool>(
      selector: (state) {
        return state.isShowForgotPass ?? false;
      },
      builder: (context, forgotPass) {
        return forgotPass
            ? TextButton(
                onPressed: () {
                  AppCoordinator.showResetPassScreen();
                },
                child: Text(
                  S.of(context).forGotYourPassword,
                  style: AppTextStyle.textButtonTextStyle.copyWith(
                      fontSize: AppFontSize.f14, color: AppColors.primary),
                ))
            : const SizedBox.shrink();
      },
    );
  }

  Widget _renderNotYouButton(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          XTextAndIconButton(
            label: S.of(context).notYou,
            onPressed: () => AppCoordinator.showSignInEmailScreen(),
          ),
        ],
      ),
    );
  }

  Widget _renderAvatar() {
    return BlocSelector<SignInBloc, SignInState, Uint8List?>(
      selector: (state) {
        return state.avatar;
      },
      builder: (context, avatar) {
        return XAvatar(
          imageSize: AppSize.s105,
          memoryData: avatar,
          imageType: avatar == null ? ImageType.none : ImageType.memory,
          borderColor: AppColors.secondPrimary,
        );
      },
    );
  }
}
