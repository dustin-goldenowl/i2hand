import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i2hand/src/feature/payment/logic/payment_bloc.dart';
import 'package:i2hand/src/feature/payment/logic/payment_state.dart';
import 'package:i2hand/src/localization/localization_utils.dart';
import 'package:i2hand/src/theme/colors.dart';
import 'package:i2hand/src/theme/styles.dart';
import 'package:i2hand/src/theme/value.dart';
import 'package:i2hand/src/utils/padding_utils.dart';
import 'package:i2hand/src/utils/string_ext.dart';
import 'package:i2hand/src/utils/utils.dart';
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
  void initState() {
    super.initState();
    context.read<PaymentBloc>().inital(context);
  }

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
    return BlocBuilder<PaymentBloc, PaymentState>(
      buildWhen: (previous, current) => previous.address != current.address,
      builder: (context, state) {
        return XShippingAddressSection(
          address: state.address,
          onChangeAddress: (address) =>
              context.read<PaymentBloc>().setAddress(address),
        );
      },
    );
  }

  Widget _renderContactInforSection(BuildContext context) {
    return BlocBuilder<PaymentBloc, PaymentState>(
      buildWhen: (previous, current) => previous.user != current.user,
      builder: (context, state) {
        return XContactInformationSection(
            email: state.user.email ?? '',
            phone: state.phoneNumber,
            onChangeContact: (phoneContact) {
              context.read<PaymentBloc>().setPhoneNumber(phoneContact);
            });
      },
    );
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
    return Row(
      children: [
        _renderProductImage(context),
        XPaddingUtils.horizontalPadding(width: AppPadding.p15),
        _renderProductName(context),
        XPaddingUtils.horizontalPadding(width: AppPadding.p15),
        _renderPrice(context),
      ],
    );
  }

  Widget _renderProductImage(BuildContext context) {
    return BlocBuilder<PaymentBloc, PaymentState>(
      buildWhen: (previous, current) => previous.product != current.product,
      builder: (context, state) {
        return XAvatar(
          imageSize: AppSize.s48,
          memoryData: state.product.image?.convertToUint8List(),
          imageType: isNullOrEmpty(state.product.image)
              ? ImageType.none
              : ImageType.memory,
        );
      },
    );
  }

  Widget _renderProductName(BuildContext context) {
    return Expanded(
        child: BlocBuilder<PaymentBloc, PaymentState>(
      buildWhen: (previous, current) => previous.product != current.product,
      builder: (context, state) {
        return Text(
          state.product.title,
          style: AppTextStyle.contentTexStyle.copyWith(
            fontSize: AppFontSize.f12,
            color: AppColors.black,
          ),
          maxLines: AppLines.l2,
          overflow: TextOverflow.ellipsis,
        );
      },
    ));
  }

  Widget _renderPrice(BuildContext context) {
    return BlocBuilder<PaymentBloc, PaymentState>(
      buildWhen: (previous, current) => previous.product != current.product,
      builder: (context, state) {
        return Text(
          Utils.createPriceText(state.product.price),
          style: AppTextStyle.titleTextStyle.copyWith(
            color: AppColors.text,
            fontSize: AppFontSize.f18,
          ),
        );
      },
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
      child: BlocSelector<PaymentBloc, PaymentState, double>(
        selector: (state) {
          return state.totalPrice;
        },
        builder: (context, price) {
          return Text(
            Utils.createPriceText(price),
            style:
                AppTextStyle.titleTextStyle.copyWith(fontSize: AppFontSize.f18),
          );
        },
      ),
    );
  }

  Widget _renderPayButton(BuildContext context) {
    return Expanded(
      child: XFillButton(
          bgColor: AppColors.text,
          onPressed: () => context.read<PaymentBloc>().paidProduct(),
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
