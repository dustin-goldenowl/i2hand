import 'package:flutter/material.dart';
import 'package:i2hand/package/dismiss_keyboard/dismiss_keyboard.dart';
import 'package:i2hand/src/localization/localization_utils.dart';
import 'package:i2hand/src/network/model/country/country_code.dart';
import 'package:i2hand/src/router/coordinator.dart';
import 'package:i2hand/src/theme/colors.dart';
import 'package:i2hand/src/theme/styles.dart';
import 'package:i2hand/src/theme/value.dart';
import 'package:i2hand/src/utils/padding_utils.dart';
import 'package:i2hand/widget/appbar/app_bar.dart';
import 'package:i2hand/widget/button/fill_button.dart';
import 'package:i2hand/widget/text_field/phone_input.dart';
import 'package:i2hand/widget/text_field/text_field.dart';

class XContactInforBottomsheet extends StatelessWidget {
  const XContactInforBottomsheet({
    super.key,
    required this.email,
    required this.phone,
    required this.province,
  });
  final String email;
  final String phone;
  final CountryCode province;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius:
          const BorderRadius.vertical(top: Radius.circular(AppRadius.r16)),
      clipBehavior: Clip.hardEdge,
      child: Scaffold(
        backgroundColor: AppColors.white,
        bottomNavigationBar: _renderBottomButtonSection(context),
        body: DismissKeyBoard(
          child: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _renderAppBar(context),
                  _renderEmailField(context),
                  _renderPhoneField(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _renderAppBar(BuildContext context) {
    return XAppBar(
      titlePage: S.of(context).contactInformation,
    );
  }

  Widget _renderEmailField(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppPadding.p20,
        vertical: AppPadding.p6,
      ),
      child: XTextField(
        label: S.of(context).email,
        hintText: S.of(context).email,
        onChanged: (email) {},
        initText: email,
        prefix: const Icon(Icons.email),
        isEnable: false,
      ),
    );
  }

  Widget _renderPhoneField(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppPadding.p20,
        vertical: AppPadding.p6,
      ),
      child: XPhoneInput(
        fieldColor: AppColors.grey8,
        countryCodeDomain: province,
        onChangedInput: (dial) {},
        onPressCountryFlag: () {},
        hintText: S.of(context).phone,
      ),
    );
  }

  Widget _renderBottomButtonSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppPadding.p20,
        vertical: AppPadding.p30,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          _renderCancelButton(context),
          XPaddingUtils.horizontalPadding(width: AppPadding.p16),
          _renderSaveButton(context),
        ],
      ),
    );
  }

  Widget _renderCancelButton(BuildContext context) {
    return Expanded(
      child: XFillButton(
          bgColor: AppColors.black3,
          onPressed: () => AppCoordinator.pop(),
          label: Text(
            S.of(context).cancel,
            style: AppTextStyle.buttonTextStylePrimary
                .copyWith(color: AppColors.white),
          )),
    );
  }

  Widget _renderSaveButton(BuildContext context) {
    return Expanded(
      child: XFillButton(
        onPressed: () {},
        label: Text(
          S.of(context).save,
          style: AppTextStyle.buttonTextStylePrimary,
        ),
      ),
    );
  }
}
