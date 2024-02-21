import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i2hand/gen/assets.gen.dart';
import 'package:i2hand/package/dismiss_keyboard/dismiss_keyboard.dart';
import 'package:i2hand/src/dialog/toast_wrapper.dart';
import 'package:i2hand/src/dialog/widget/loading_process.dart';
import 'package:i2hand/src/feature/authentication/forgot_password/logic/reset_password_bloc.dart';
import 'package:i2hand/src/feature/authentication/forgot_password/logic/reset_password_state.dart';
import 'package:i2hand/src/localization/localization_utils.dart';
import 'package:i2hand/src/router/coordinator.dart';
import 'package:i2hand/src/theme/colors.dart';
import 'package:i2hand/src/theme/styles.dart';
import 'package:i2hand/src/theme/value.dart';
import 'package:i2hand/src/utils/padding_utils.dart';
import 'package:i2hand/widget/avatar/avatar.dart';
import 'package:i2hand/widget/button/fill_button.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  @override
  void initState() {
    super.initState();
  }

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
          _renderRecoveryPasswordText(context),
          XPaddingUtils.verticalPadding(height: AppPadding.p10),
          _renderSubTitle(context),
          XPaddingUtils.verticalPadding(height: AppPadding.p10),
          _renderResetPassField(context),
          _renderNextButton(context),
          XPaddingUtils.verticalPadding(height: AppPadding.p10),
          _renderCancelButton(context),
          XPaddingUtils.verticalPadding(height: AppPadding.p45),
        ],
      ),
    );
  }

  Widget _renderRecoveryPasswordText(BuildContext context) {
    return DefaultTextStyle(
      style: AppTextStyle.titleTextStyle.copyWith(fontSize: AppFontSize.f21),
      child: Text(S.of(context).passwordRecovery),
    );
  }

  Widget _renderSubTitle(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppPadding.p10),
      child: Text(
        S.of(context).howYouWouldLikeToRestore,
        textAlign: TextAlign.center,
        style: AppTextStyle.contentTexStyle
            .copyWith(fontSize: AppFontSize.f18, color: AppColors.text),
      ),
    );
  }

  Widget _renderResetPassField(BuildContext context) {
    return BlocSelector<ResetPasswordBloc, ResetPasswordState, String>(
      selector: (state) {
        return state.selectedOption;
      },
      builder: (context, selectedOption) {
        return Expanded(
          child: Column(
            children: [
              _renderSmsField(context,
                  label: S.of(context).sms,
                  value: S.of(context).sms,
                  groupValue: selectedOption),
              XPaddingUtils.verticalPadding(height: AppPadding.p10),
              _renderSmsField(context,
                  label: S.of(context).email,
                  value: S.of(context).email,
                  groupValue: selectedOption),
            ],
          ),
        );
      },
    );
  }

  Widget _renderNextButton(BuildContext context) {
    return BlocListener<ResetPasswordBloc, ResetPasswordState>(
      listener: (context, state) {
        switch (state.status) {
          case ResetPasswordStatus.loading:
            XToast.showLoading();
            break;
          case ResetPasswordStatus.failed:
            XToast.hideLoading();
            XToast.error(S.of(context).someThingWentWrong);
            context.read<ResetPasswordBloc>().resetStatus();
            break;
          case ResetPasswordStatus.successed:
            XToast.hideLoading();
            context.read<ResetPasswordBloc>().resetStatus();
            AppCoordinator.showSendMailSuccess();
            break;
          default:
            if (XToast.isShowLoading) hideLoading();
            break;
        }
      },
      child: XFillButton(
        label: Text(
          S.of(context).next,
          style: AppTextStyle.buttonTextStylePrimary,
        ),
        onPressed: () {
          context.read<ResetPasswordBloc>().resetPassword(context);
        },
      ),
    );
  }

  Widget _renderAvatar() {
    return const XAvatar(
      imageSize: AppSize.s105,
    );
  }

  Widget _renderCancelButton(BuildContext context) {
    return TextButton(
        onPressed: () => AppCoordinator.pop(),
        child: Text(
          S.of(context).cancel,
          style: AppTextStyle.contentTexStyle,
        ));
  }

  Widget _renderSmsField(
    BuildContext context, {
    required String label,
    required String value,
    required String groupValue,
  }) {
    final isSelected = value.compareTo(groupValue) == 0;
    return GestureDetector(
      onTap: () => context.read<ResetPasswordBloc>().onChangedOption(value),
      child: Container(
        width: AppSize.s200,
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.backgroundButton
              : AppColors.pinkBackgroundSecondary,
          borderRadius: BorderRadius.circular(AppRadius.r16),
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
                    color: isSelected ? AppColors.primary : AppColors.black,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.w500),
              ),
            ),
            isSelected
                ? Container(
                    width: AppSize.s24,
                    height: AppSize.s24,
                    margin: const EdgeInsets.all(AppPadding.p7),
                    decoration: BoxDecoration(
                        color: AppColors.primary,
                        border: Border.all(
                            color: AppColors.white, width: AppSize.s2),
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
                        border: Border.all(
                            color: AppColors.white, width: AppSize.s2),
                        borderRadius: BorderRadius.circular(AppRadius.r12)),
                  ),
          ],
        ),
      ),
    );
  }
}
