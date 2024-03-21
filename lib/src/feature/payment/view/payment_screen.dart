import 'package:flutter/material.dart';
import 'package:i2hand/src/localization/localization_utils.dart';
import 'package:i2hand/src/service/shared_pref.dart';
import 'package:i2hand/src/theme/colors.dart';
import 'package:i2hand/src/theme/styles.dart';
import 'package:i2hand/src/theme/value.dart';
import 'package:i2hand/src/utils/padding_utils.dart';
import 'package:i2hand/widget/appbar/app_bar.dart';
import 'package:i2hand/widget/avatar/avatar.dart';
import 'package:i2hand/widget/bottomsheet/payment_method_bottomsheet.dart';
import 'package:i2hand/widget/button/fill_button.dart';
import 'package:i2hand/widget/chip/label_chip.dart';
import 'package:i2hand/widget/section/information_section.dart';
import 'package:i2hand/widget/section/shipping_address_section.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _renderBottomBar(context),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            _renderAppBar(context),
            XPaddingUtils.verticalPadding(height: AppPadding.p10),
            _renderAddressSection(context),
            XPaddingUtils.verticalPadding(height: AppPadding.p10),
            _renderContactInforSection(context),
            XPaddingUtils.verticalPadding(height: AppPadding.p20),
            _renderItemSection(context),
            XPaddingUtils.verticalPadding(height: AppPadding.p20),
            _renderShippingOptionsSection(context),
            XPaddingUtils.verticalPadding(height: AppPadding.p20),
            _renderPaymentMethodSection(context),
          ],
        ),
      )),
    );
  }

  Widget _renderAppBar(BuildContext context) {
    return XAppBar(
      titlePage: S.of(context).payment,
    );
  }

  Widget _renderAddressSection(BuildContext context) {
    return XShippingAddressSection(onChangeAddress: (address) {
      //TODO: change address text => save to blocr
    });
  }

  Widget _renderContactInforSection(BuildContext context) {
    final email = SharedPrefs.I.getUser()?.email ?? '';
    return XContactInformationSection(
        email: email,
        onChangeContact: (contact) {
          //TODO: change contact text => save to bloc
        });
  }

  Widget _renderItemSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppPadding.p20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _renderTitle(context, title: S.of(context).items),
          XPaddingUtils.verticalPadding(height: AppPadding.p10),
          _renderItemInfor(context),
        ],
      ),
    );
  }

  Widget _renderTitle(BuildContext context,
      {required String title, Widget? actions}) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style:
              AppTextStyle.titleTextStyle.copyWith(fontSize: AppFontSize.f21),
        ),
        actions ?? const SizedBox.shrink(),
      ],
    );
  }

  Widget _renderItemInfor(BuildContext context) {
    return Column(
      children: [
        _renderSellerInfor(context),
        XPaddingUtils.verticalPadding(height: AppPadding.p10),
        Row(
          children: [
            _renderProductImage(context),
            XPaddingUtils.horizontalPadding(width: AppPadding.p15),
            _renderProductName(context),
            XPaddingUtils.horizontalPadding(width: AppPadding.p15),
            _renderPrice(context),
          ],
        ),
      ],
    );
  }

  Widget _renderProductImage(BuildContext context) {
    return const XAvatar(
      imageSize: AppSize.s48,
    );
  }

  Widget _renderProductName(BuildContext context) {
    return Expanded(
        child: Text(
      S.of(context).randomText,
      style: AppTextStyle.contentTexStyle.copyWith(
        fontSize: AppFontSize.f12,
        color: AppColors.black,
      ),
      maxLines: AppLines.l2,
      overflow: TextOverflow.ellipsis,
    ));
  }

  Widget _renderPrice(BuildContext context) {
    return Text(
      S.of(context).samplePriceText,
      style: AppTextStyle.titleTextStyle.copyWith(
        color: AppColors.text,
        fontSize: AppFontSize.f18,
      ),
    );
  }

  Widget _renderSellerInfor(BuildContext context) {
    return Row(
      children: [
        const XAvatar(imageSize: AppSize.s20),
        XPaddingUtils.horizontalPadding(width: AppSize.s10),
        Expanded(
          child: Text(
            S.of(context).randomText,
            style: AppTextStyle.contentTexStyle.copyWith(
              fontSize: AppFontSize.f10,
              color: AppColors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        IconButton.filled(
          style: const ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(AppColors.primary)),
          onPressed: () {},
          iconSize: AppSize.s16,
          icon: const Icon(
            Icons.phone,
            color: AppColors.white,
          ),
        )
      ],
    );
  }

  Widget _renderShippingOptionsSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppPadding.p20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _renderTitle(context, title: S.of(context).shippingOptions),
          XPaddingUtils.verticalPadding(height: AppPadding.p10),
          _renderShippingOptions(context),
        ],
      ),
    );
  }

  Widget _renderShippingOptions(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
          vertical: AppPadding.p8, horizontal: AppPadding.p10),
      decoration: BoxDecoration(
        border: Border.all(width: AppSize.s0_5),
        borderRadius: BorderRadius.circular(AppRadius.r12),
        color: AppColors.grey7,
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              S.of(context).pleaseContactTheSeller,
              style: AppTextStyle.contentTexStyle.copyWith(
                fontSize: AppFontSize.f12,
                color: AppColors.black,
              ),
              maxLines: AppLines.l3,
            ),
          ),
          XPaddingUtils.horizontalPadding(width: AppPadding.p10),
          const Icon(Icons.keyboard_arrow_down_rounded)
        ],
      ),
    );
  }

  Widget _renderPaymentMethodSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppPadding.p20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _renderTitle(
            context,
            title: S.of(context).paymentMethod,
            actions: _renderAddLocationButton(context),
          ),
          XPaddingUtils.verticalPadding(height: AppPadding.p10),
          _renderPaymentMethod(context),
        ],
      ),
    );
  }

  Widget _renderAddLocationButton(BuildContext context) {
    return IconButton.filled(
      color: AppColors.primary,
      style: ButtonStyle(
        padding: MaterialStateProperty.all(EdgeInsets.zero),
      ),
      onPressed: () => _openPaymentMethodBottomsheet(context),
      iconSize: AppFontSize.f18,
      icon: const Icon(
        Icons.edit,
        color: AppColors.white,
      ),
    );
  }

  Widget _renderPaymentMethod(BuildContext context) {
    return Wrap(
      children: [
        XLabelChip(
          title: S.of(context).card,
          onTap: () {},
          backgroundColor: AppColors.backgroundButton,
          textStyle: AppTextStyle.titleTextStyle.copyWith(
            color: AppColors.primary,
            fontSize: AppFontSize.f15,
          ),
        )
      ],
    );
  }

  Widget _renderBottomBar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: AppPadding.p20, vertical: AppPadding.p10),
      color: AppColors.grey6,
      child: Row(
        children: [
          _renderTotalText(context),
          XPaddingUtils.horizontalPadding(width: AppPadding.p10),
          _renderTotalPrice(context),
          _renderPayButton(context),
        ],
      ),
    );
  }

  Widget _renderTotalText(BuildContext context) {
    return Text(
      S.of(context).total,
      style: AppTextStyle.extraBoldTextStyle,
    );
  }

  Widget _renderTotalPrice(BuildContext context) {
    return Expanded(
      child: Text(
        S.of(context).samplePriceText,
        style: AppTextStyle.titleTextStyle.copyWith(fontSize: AppFontSize.f18),
      ),
    );
  }

  Widget _renderPayButton(BuildContext context) {
    return Expanded(
      child: XFillButton(
          bgColor: AppColors.text,
          label: Text(
            S.of(context).pay,
            style: AppTextStyle.buttonTextStylePrimary,
          )),
    );
  }

  void _openPaymentMethodBottomsheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      builder: (_) => const FractionallySizedBox(
          heightFactor: 0.5, child: XPaymentMethodBottomsheet()),
      isScrollControlled: true,
      barrierColor: AppColors.black.withOpacity(0.6),
      enableDrag: true,
      isDismissible: true,
    ).then((valueCallback) {});
  }
}
