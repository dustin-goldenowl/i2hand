import 'package:flutter/material.dart';
import 'package:i2hand/package/dismiss_keyboard/dismiss_keyboard.dart';
import 'package:i2hand/src/localization/localization_utils.dart';
import 'package:i2hand/src/theme/colors.dart';
import 'package:i2hand/src/theme/value.dart';
import 'package:i2hand/src/utils/padding_utils.dart';
import 'package:i2hand/widget/appbar/app_bar.dart';
import 'package:i2hand/widget/avatar/avatar.dart';
import 'package:i2hand/widget/card/card_item_with_icon.dart';
import 'package:i2hand/widget/text_field/text_field.dart';

class DetailAccountScreen extends StatelessWidget {
  const DetailAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
          child: DismissKeyBoard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _renderAppBar(context),
            XPaddingUtils.verticalPadding(height: AppPadding.p20),
            _renderAvatar(context),
            XPaddingUtils.verticalPadding(height: AppPadding.p20),
            _renderInformationSection(context),
            _renderEKYCAccount(context),
          ],
        ),
      )),
    );
  }

  Widget _renderAppBar(BuildContext context) {
    return XAppBar(
      titlePage: S.of(context).setting,
      subTitlePage: S.of(context).yourProfile,
    );
  }

  Widget _renderAvatar(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: AppPadding.p20),
      child: XAvatar(
        imageSize: AppSize.s105,
        isEditable: true,
      ),
    );
  }

  Widget _renderInformationSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppPadding.p20),
      child: Column(
        children: [
          XTextField(
            filledColor: AppColors.textFieldBackground,
            hintText: S.of(context).name,
            onChanged: (text) {},
            cursorColor: AppColors.primary,
          ),
          XTextField(
            filledColor: AppColors.textFieldBackground,
            hintText: S.of(context).email,
            onChanged: (text) {},
            isEnable: false,
            cursorColor: AppColors.primary,
          ),
          XTextField(
            filledColor: AppColors.textFieldBackground,
            hintText: S.of(context).phoneLine,
            onChanged: (text) {},
            cursorColor: AppColors.primary,
            keyboardType: TextInputType.phone,
          ),
        ],
      ),
    );
  }

  Widget _renderEKYCAccount(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppPadding.p20),
      child: XCardItemWithIcon(
        text: S.of(context).verifyYourAccount,
        firstItem: true,
        lastItem: true,
        iconPath: Icons.error_rounded,
        backgroundColor: AppColors.backgroundButton,
        iconColor: AppColors.errorColor,
      ),
    );
  }
}
