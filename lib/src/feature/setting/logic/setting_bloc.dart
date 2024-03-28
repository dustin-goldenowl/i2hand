import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:i2hand/src/dialog/toast_wrapper.dart';
import 'package:i2hand/src/feature/setting/logic/setting_state.dart';
import 'package:i2hand/src/localization/localization_utils.dart';
import 'package:i2hand/src/network/data/sign/sign_repository.dart';
import 'package:i2hand/src/network/data/user/user_repository.dart';
import 'package:i2hand/src/network/model/user/user.dart';
import 'package:i2hand/src/router/coordinator.dart';
import 'package:i2hand/src/service/shared_pref.dart';
import 'package:i2hand/src/theme/colors.dart';
import 'package:i2hand/src/theme/styles.dart';
import 'package:i2hand/src/theme/value.dart';
import 'package:i2hand/src/utils/base_cubit.dart';
import 'package:i2hand/src/utils/padding_utils.dart';
import 'package:i2hand/widget/button/fill_button.dart';

class SettingBloc extends BaseCubit<SettingState> {
  SettingBloc() : super(SettingState());

  void showLogOutDialog(BuildContext context) {
    XToast.showFailedDialog(
      title: S.of(context).logOut,
      subTitle: S.of(context).areYouSureWantToLogOut,
      actions: _renderOptionsButtonSection(context),
    );
  }

  Widget _renderOptionsButtonSection(BuildContext context,
      {bool isSignOut = true}) {
    return Row(
      children: [
        _renderCancelButton(context),
        XPaddingUtils.horizontalPadding(width: AppPadding.p10),
        isSignOut ? _renderLogoutButton(context) : _renderDeleteButton(context),
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
        bgColor: AppColors.errorColor,
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

  void showDeleteAccountDialog(BuildContext context) {
    XToast.showFailedDialog(
      title: S.of(context).youAreGoingToDeleteYourAccount,
      subTitle: S.of(context).youWontBeAbleToRestoreYourData,
      actions: _renderOptionsButtonSection(context, isSignOut: false),
    );
  }

  Widget _renderDeleteButton(BuildContext context) {
    return Expanded(
      child: XFillButton(
        bgColor: AppColors.errorColor,
        onPressed: () async {
          // Show loading screen
          XToast.showLoading();
          await GetIt.I.get<UserRepository>().deleteUser(_getCurrentUser());
          final result = await GetIt.I
              .get<SignRepository>()
              .removeAccount(_getCurrentUser());
          XToast.hideLoading();
          if (result.isError == false) {
            AppCoordinator.showStartScreen();
            return;
          }
          XToast.error(S.text.someThingWentWrong);
        },
        label: Text(
          S.of(context).delete,
          style: AppTextStyle.buttonTextStylePrimary,
        ),
      ),
    );
  }
}
