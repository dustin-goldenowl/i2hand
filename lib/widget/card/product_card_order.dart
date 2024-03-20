import 'package:flutter/material.dart';
import 'package:i2hand/src/localization/localization_utils.dart';
import 'package:i2hand/src/theme/colors.dart';
import 'package:i2hand/src/theme/styles.dart';
import 'package:i2hand/src/theme/value.dart';
import 'package:i2hand/src/utils/padding_utils.dart';

class XProductCartOrder extends StatelessWidget {
  const XProductCartOrder({
    super.key,
    this.orderNumber = '',
    this.status = '',
    this.delivery = '',
    required this.image,
  });
  final String orderNumber;
  final String status;
  final String delivery;
  final Widget image;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _renderImageProduct(),
        XPaddingUtils.horizontalPadding(width: AppPadding.p10),
        _renderInforOrder(context),
      ],
    );
  }

  Widget _renderImageProduct() {
    return Container(
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppRadius.r10),
            boxShadow: [
              BoxShadow(
                offset: const Offset(5, 5),
                blurRadius: 7,
                color: Colors.black.withOpacity(.1),
              ),
            ],
            border: Border.all(
              width: AppSize.s4,
              color: AppColors.white,
              strokeAlign: BorderSide.strokeAlignOutside,
            )),
        child: image);
  }

  Widget _renderInforOrder(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _renderOrderNumber(context),
          XPaddingUtils.verticalPadding(height: AppPadding.p4),
          _renderOrderDelivery(context),
          XPaddingUtils.verticalPadding(height: AppPadding.p6),
          _renderOrderStatus(context),
        ],
      ),
    );
  }

  Widget _renderOrderNumber(BuildContext context) {
    return DefaultTextStyle(
      style: AppTextStyle.titleTextStyle.copyWith(
        fontSize: AppFontSize.f14,
      ),
      child: Row(
        children: [
          Text(S.of(context).order),
          Text(
            orderNumber,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _renderOrderStatus(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          status,
          style:
              AppTextStyle.titleTextStyle.copyWith(fontSize: AppFontSize.f18),
        ),
        _renderStatusButton(context),
      ],
    );
  }

  Widget _renderOrderDelivery(BuildContext context) {
    return Text(
      delivery,
      style: AppTextStyle.hintTextStyle.copyWith(
        color: AppColors.text,
      ),
    );
  }

  Widget _renderStatusButton(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(
        minWidth: AppSize.s90,
        maxWidth: AppSize.s90,
        minHeight: AppSize.s40,
        maxHeight: AppSize.s40,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppRadius.r8),
        color: AppColors.primary,
      ),
      alignment: Alignment.center,
      child: Center(
        child: Text(
          S.of(context).track,
          style: AppTextStyle.buttonTextStylePrimary,
        ),
      ),
    );
  }
}
