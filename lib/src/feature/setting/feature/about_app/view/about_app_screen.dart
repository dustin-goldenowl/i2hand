import 'package:flutter/material.dart';
import 'package:i2hand/gen/assets.gen.dart';
import 'package:i2hand/src/config/constants/app_const.dart';
import 'package:i2hand/src/localization/localization_utils.dart';
import 'package:i2hand/src/router/coordinator.dart';
import 'package:i2hand/src/theme/colors.dart';
import 'package:i2hand/src/theme/styles.dart';
import 'package:i2hand/src/theme/value.dart';
import 'package:i2hand/src/utils/padding_utils.dart';

class AboutAppScreen extends StatelessWidget {
  const AboutAppScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppPadding.p20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _renderBackButton(),
              _renderIconApp(),
              XPaddingUtils.verticalPadding(height: AppPadding.p15),
              _renderTitle(context),
              XPaddingUtils.verticalPadding(height: AppPadding.p15),
              _renderContent(context),
              XPaddingUtils.verticalPadding(height: AppPadding.p15),
              _renderAdminMail(context),
              XPaddingUtils.verticalPadding(height: AppPadding.p45),
            ],
          ),
        ),
      )),
    );
  }

  Widget _renderBackButton() {
    return Align(
      alignment: Alignment.centerLeft,
      child: IconButton(
          onPressed: () => AppCoordinator.pop(),
          icon: const Icon(Icons.arrow_back)),
    );
  }

  Widget _renderIconApp() {
    return Assets.images.logo.image();
  }

  Widget _renderTitle(BuildContext context) {
    return Text(
      S.of(context).aboutApp,
      style: AppTextStyle.titleTextStyle.copyWith(fontSize: AppFontSize.f28),
    );
  }

  Widget _renderContent(BuildContext context) {
    return Text(
      S.of(context).appDescription,
      style: AppTextStyle.contentTexStyle.copyWith(
          fontSize: AppFontSize.f15,
          color: AppColors.black,
          fontWeight: FontWeight.w300),
    );
  }

  Widget _renderAdminMail(BuildContext context) {
    return Text(
      AppConstantData.adminEmail,
      style: AppTextStyle.labelStyle.copyWith(
        fontSize: AppFontSize.f16,
        fontWeight: FontWeight.bold,
        color: AppColors.text,
      ),
    );
  }
}
