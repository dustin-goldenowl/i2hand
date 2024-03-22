import 'package:flutter/material.dart';
import 'package:i2hand/src/localization/localization_utils.dart';
import 'package:i2hand/src/router/coordinator.dart';
import 'package:i2hand/src/theme/colors.dart';
import 'package:i2hand/src/theme/decorations.dart';
import 'package:i2hand/src/theme/styles.dart';
import 'package:i2hand/src/theme/value.dart';
import 'package:i2hand/src/utils/padding_utils.dart';
import 'package:i2hand/src/utils/string_utils.dart';

class XShippingAddressSection extends StatelessWidget {
  const XShippingAddressSection(
      {super.key, this.address, required this.onChangeAddress});

  final String? address;
  final Function(String) onChangeAddress;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      alignment: Alignment.centerLeft,
      margin: const EdgeInsets.symmetric(
        horizontal: AppMargin.m20,
      ),
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
            S.of(context).shippingAddress,
            style:
                AppTextStyle.titleTextStyle.copyWith(fontSize: AppFontSize.f14),
          ),
          _renderAddress(context),
        ],
      ),
    );
  }

  Widget _renderAddress(BuildContext context) {
    return Row(
      children: [
        _renderShippingAddressText(context),
        XPaddingUtils.horizontalPadding(width: AppPadding.p40),
        _renderAddLocationButton(context),
      ],
    );
  }

  Widget _renderShippingAddressText(BuildContext context) {
    return Expanded(
      child: Text(
        StringUtils.isNullOrEmpty(address?.trim())
            ? S.of(context).pleaseAddYourAddress
            : StringUtils.getAddressText(rawAddress: address!),
        style: AppTextStyle.contentTexStyle.copyWith(
          fontSize: AppFontSize.f10,
          color: AppColors.black,
        ),
      ),
    );
  }

  Widget _renderAddLocationButton(BuildContext context) {
    return IconButton.filled(
      color: AppColors.primary,
      style: ButtonStyle(
        padding: MaterialStateProperty.all(EdgeInsets.zero),
      ),
      onPressed: () async => await AppCoordinator.showSelectLocationPage(
        address: address ?? S.of(context).emptyRouteParam,
      ).then((value) {
        if (value == null) return;
        onChangeAddress.call(value);
      }),
      iconSize: AppFontSize.f15,
      icon: const Icon(
        Icons.edit,
        color: AppColors.white,
      ),
    );
  }
}
