import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:i2hand/src/dialog/toast_wrapper.dart';
import 'package:i2hand/src/localization/localization_utils.dart';
import 'package:i2hand/src/network/data/sign/sign_repository.dart';
import 'package:i2hand/src/network/model/user/user.dart';
import 'package:i2hand/src/router/coordinator.dart';
import 'package:i2hand/src/service/shared_pref.dart';
import 'package:i2hand/src/theme/colors.dart';
import 'package:i2hand/src/theme/styles.dart';
import 'package:i2hand/src/theme/value.dart';
import 'package:i2hand/src/utils/padding_utils.dart';
import 'package:i2hand/widget/appbar/app_bar.dart';
import 'package:i2hand/widget/button/fill_button.dart';
import 'package:i2hand/widget/card/card_item_with_icon.dart';
import 'package:i2hand/widget/separate/dash_separate.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _renderAppBar(context),
              _renderProfileSection(context),
              XPaddingUtils.verticalPadding(height: AppPadding.p23),
              _renderShopSection(context),
              XPaddingUtils.verticalPadding(height: AppPadding.p23),
              _renderAboutAppSection(context),
              XPaddingUtils.verticalPadding(height: AppPadding.p23),
              _renderDeleteAccountSection(context),
              _renderLogoutSection(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _renderAppBar(BuildContext context) {
    return XAppBar(
      titlePage: S.of(context).setting,
    );
  }

  Widget _renderProfileSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppPadding.p20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _renderLabel(label: S.of(context).personal),
          _renderPersonalOptions(context),
        ],
      ),
    );
  }

  Widget _renderLabel({required String label}) {
    return Text(
      label,
      style: AppTextStyle.labelStyle
          .copyWith(fontSize: AppFontSize.f20, fontWeight: FontWeight.w900),
    );
  }

  Widget _renderPersonalOptions(BuildContext context) {
    return Column(
      children: [
        _renderOptionItem(
          label: S.of(context).profile,
          onTap: () => AppCoordinator.showDetailAccountScreen(),
        ),
        const XDashSeparator(color: AppColors.grey6),
        _renderOptionItem(label: S.of(context).shippingAddress, onTap: () {}),
        const XDashSeparator(color: AppColors.grey6),
        _renderOptionItem(label: S.of(context).paymentMethods, onTap: () {}),
        const XDashSeparator(color: AppColors.grey6),
      ],
    );
  }

  Widget _renderOptionItem({required String label, required Function onTap}) {
    return XCardItemWithIcon(
      text: label,
      iconPath: Icons.arrow_forward_ios_outlined,
      onTap: onTap,
    );
  }

  Widget _renderShopSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppPadding.p20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _renderLabel(label: S.of(context).shop),
          _renderShopOptions(context),
        ],
      ),
    );
  }

  Widget _renderShopOptions(BuildContext context) {
    return Column(
      children: [
        _renderOptionItem(label: S.of(context).country, onTap: () {}),
        const XDashSeparator(color: AppColors.grey6),
        _renderOptionItem(label: S.of(context).currency, onTap: () {}),
        const XDashSeparator(color: AppColors.grey6),
      ],
    );
  }

  Widget _renderAboutAppSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppPadding.p20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _renderLabel(label: S.of(context).aboutApp),
          _renderAboutOptions(context),
        ],
      ),
    );
  }

  Widget _renderAboutOptions(BuildContext context) {
    return Column(
      children: [
        _renderOptionItem(
            label: S.of(context).termsAndConditions, onTap: () {}),
        const XDashSeparator(color: AppColors.grey6),
        _renderOptionItem(label: S.of(context).language, onTap: () {}),
        const XDashSeparator(color: AppColors.grey6),
        _renderOptionItem(
          label: S.of(context).abouti2hand,
          onTap: () => AppCoordinator.showAboutAppScreen(),
        ),
        const XDashSeparator(color: AppColors.grey6),
      ],
    );
  }

  Widget _renderDeleteAccountSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppPadding.p20),
      child: TextButton(
          onPressed: () {},
          child: Text(
            S.of(context).deleteMyAccount,
            style: AppTextStyle.buttonTextStylePrimary
                .copyWith(color: AppColors.errorColor),
          )),
    );
  }

  Widget _renderLogoutSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSize.s20),
      child: XFillButton(
        onPressed: () => _showLogOutDialog(context),
        label: Text(
          S.of(context).logOut,
          style: AppTextStyle.buttonTextStylePrimary,
        ),
        bgColor: AppColors.errorColor,
      ),
    );
  }

  void _showLogOutDialog(BuildContext context) {
    XToast.showFailedDialog(
      title: S.of(context).logOut,
      subTitle: S.of(context).areYouSureWantToLogOut,
      actions: _renderLogoutButtonSection(context),
    );
  }

  Widget _renderLogoutButtonSection(BuildContext context) {
    return Row(
      children: [
        _renderCancelButton(context),
        XPaddingUtils.horizontalPadding(width: AppPadding.p10),
        _renderLogoutButton(context),
      ],
    );
  }

  Widget _renderCancelButton(BuildContext context) {
    return Expanded(
      child: XFillButton(
        bgColor: AppColors.black,
        onPressed: () {
          XToast.hideLoading();
        },
        label: Text(
          S.of(context).cancel,
          style: AppTextStyle.buttonTextStylePrimary,
        ),
      ),
    );
  }

  Widget _renderLogoutButton(BuildContext context) {
    return Expanded(
      child: XFillButton(
        bgColor: AppColors.red,
        onPressed: () async {
          // Show loading screen
          XToast.showLoading();
          final result =
              await GetIt.I.get<SignRepository>().logOut(_getCurrentUser());
          XToast.hideLoading();
          if (result.isError == false) {
            AppCoordinator.showStartScreen();
            return;
          }
          XToast.error(S.text.someThingWentWrong);
        },
        label: Text(
          S.of(context).logOut,
          style: AppTextStyle.buttonTextStylePrimary,
        ),
      ),
    );
  }

  MUser _getCurrentUser() {
    return SharedPrefs.I.getUser() ?? MUser.empty();
  }
}
