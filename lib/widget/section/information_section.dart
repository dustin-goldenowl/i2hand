import 'package:flutter/material.dart';
import 'package:i2hand/src/localization/localization_utils.dart';
import 'package:i2hand/src/network/model/country/country_code.dart';
import 'package:i2hand/src/theme/colors.dart';
import 'package:i2hand/src/theme/decorations.dart';
import 'package:i2hand/src/theme/styles.dart';
import 'package:i2hand/src/theme/value.dart';
import 'package:i2hand/src/utils/padding_utils.dart';
import 'package:i2hand/src/utils/string_utils.dart';
import 'package:i2hand/widget/bottomsheet/contact_infor_bottomsheer.dart';

class XContactInformationSection extends StatelessWidget {
  const XContactInformationSection({
    super.key,
    this.phone,
    required this.onChangeContact,
    required this.email,
  });

  final String? phone;
  final String email;
  final Function(String) onChangeContact;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      alignment: Alignment.centerLeft,
      margin: const EdgeInsets.symmetric(horizontal: AppMargin.m20),
      padding: const EdgeInsets.only(
        left: AppPadding.p16,
        right: AppPadding.p12,
        top: AppPadding.p8,
        bottom: AppPadding.p8,
      ),
      decoration: BoxDecoration(
        color: AppColors.grey8,
        boxShadow: AppDecorations.fullShadow(),
        borderRadius: BorderRadius.circular(AppRadius.r16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            S.of(context).contactInformation,
            style:
                AppTextStyle.titleTextStyle.copyWith(fontSize: AppFontSize.f14),
          ),
          _renderInformation(context),
        ],
      ),
    );
  }

  Widget _renderInformation(BuildContext context) {
    return Row(
      children: [
        _renderContactInformationText(context),
        XPaddingUtils.horizontalPadding(width: AppPadding.p40),
        _renderAddInformationButton(context),
      ],
    );
  }

  Widget _renderContactInformationText(BuildContext context) {
    return Expanded(
      child: DefaultTextStyle(
        style: AppTextStyle.contentTexStyle.copyWith(
          fontSize: AppFontSize.f10,
          color: AppColors.black,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              StringUtils.isNullOrEmpty(phone?.trim())
                  ? S.of(context).pleaseAddYourAddress
                  : phone!,
            ),
            Text(email),
          ],
        ),
      ),
    );
  }

  Widget _renderAddInformationButton(BuildContext context) {
    return IconButton.filled(
      color: AppColors.primary,
      style: ButtonStyle(
        padding: MaterialStateProperty.all(EdgeInsets.zero),
      ),
      onPressed: () => _openEditContactInforBottomsheet(context),
      iconSize: AppFontSize.f15,
      icon: const Icon(
        Icons.edit,
        color: AppColors.white,
      ),
    );
  }

  void _openEditContactInforBottomsheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      builder: (_) => FractionallySizedBox(
          heightFactor: 0.5,
          child: XContactInforBottomsheet(
            email: email,
            phone: phone ?? '',
            province: CountryCode(),
          )),
      isScrollControlled: true,
      barrierColor: AppColors.black.withOpacity(0.6),
      enableDrag: true,
      isDismissible: true,
    ).then((valueCallback) {});
  }
}
