import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i2hand/gen/assets.gen.dart';
import 'package:i2hand/package/dismiss_keyboard/dismiss_keyboard.dart';
import 'package:i2hand/src/dialog/toast_wrapper.dart';
import 'package:i2hand/src/feature/authentication/forgot_password/logic/reset_password_bloc.dart';
import 'package:i2hand/src/feature/authentication/forgot_password/logic/reset_password_state.dart';
import 'package:i2hand/src/localization/localization_utils.dart';
import 'package:i2hand/src/router/coordinator.dart';
import 'package:i2hand/src/theme/colors.dart';
import 'package:i2hand/src/theme/styles.dart';
import 'package:i2hand/src/theme/value.dart';
import 'package:i2hand/src/utils/padding_utils.dart';
import 'package:i2hand/src/utils/string_ext.dart';
import 'package:i2hand/widget/avatar/avatar.dart';
import 'package:i2hand/widget/button/fill_button.dart';

class SendMailSuccessScreen extends StatefulWidget {
  const SendMailSuccessScreen({super.key});

  @override
  State<SendMailSuccessScreen> createState() => _SendMailSuccessScreenState();
}

class _SendMailSuccessScreenState extends State<SendMailSuccessScreen> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    context.read<ResetPasswordBloc>().initial(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DismissKeyBoard(
        child: Stack(
          children: [
            _renderBackground(),
            _renderResetPasswordBody(context),
          ],
        ),
      ),
    );
  }

  Widget _renderBackground() {
    return Assets.svg.bubbles3
        .svg(width: double.infinity, alignment: Alignment.topCenter);
  }

  Widget _renderResetPasswordBody(BuildContext context) {
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
          _renderSendSuccessText(context),
          XPaddingUtils.verticalPadding(height: AppPadding.p10),
          _renderSubTitle(context),
          _renderContinueButton(context),
          XPaddingUtils.verticalPadding(height: AppPadding.p10),
          _renderResendButton(context),
          XPaddingUtils.verticalPadding(height: AppPadding.p45),
        ],
      ),
    );
  }

  Widget _renderSendSuccessText(BuildContext context) {
    return DefaultTextStyle(
      style: AppTextStyle.titleTextStyle.copyWith(fontSize: AppFontSize.f21),
      child: Text(S.of(context).passwordLinkSend.capitalizeEachText()),
    );
  }

  Widget _renderSubTitle(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppPadding.p10),
        child: Text(
          S.of(context).youShouldReceiveAnEmail,
          textAlign: TextAlign.center,
          style: AppTextStyle.contentTexStyle
              .copyWith(fontSize: AppFontSize.f18, color: AppColors.text),
        ),
      ),
    );
  }

  Widget _renderContinueButton(BuildContext context) {
    return BlocListener<ResetPasswordBloc, ResetPasswordState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        switch (state.status) {
          case ResetPasswordStatus.loading:
            XToast.showLoading();
            break;
          case ResetPasswordStatus.failed:
            if (XToast.isShowLoading) XToast.hideLoading();
            XToast.error(S.of(context).someThingWentWrong);
            context.read<ResetPasswordBloc>().resetStatus();
            break;
          case ResetPasswordStatus.successed:
            if (XToast.isShowLoading) XToast.hideLoading();
            break;
          default:
            if (XToast.isShowLoading) XToast.hideLoading();
            break;
        }
      },
      child: XFillButton(
        label: Text(
          S.of(context).continueToLogin,
          style: AppTextStyle.buttonTextStylePrimary,
        ),
        onPressed: () {
          AppCoordinator.showSignInPassScreen();
        },
      ),
    );
  }

  Widget _renderAvatar() {
    return BlocSelector<ResetPasswordBloc, ResetPasswordState, Uint8List?>(
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

  Widget _renderResendButton(BuildContext context) {
    return XFillButton(
      bgColor: AppColors.backgroundButton,
      label: Text(
        S.of(context).didntReceiveALink,
        style: AppTextStyle.buttonTextStylePrimary
            .copyWith(color: AppColors.black, fontWeight: FontWeight.normal),
      ),
      onPressed: () {
        context.read<ResetPasswordBloc>().resetPassword(context);
      },
    );
  }
}
