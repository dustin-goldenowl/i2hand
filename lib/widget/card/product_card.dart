import 'package:flutter/material.dart';
import 'package:i2hand/src/network/model/product/product.dart';
import 'package:i2hand/src/theme/colors.dart';
import 'package:i2hand/src/theme/styles.dart';
import 'package:i2hand/src/theme/value.dart';
import 'package:i2hand/src/utils/string_ext.dart';
import 'package:i2hand/src/utils/utils.dart';

class XProductCard extends StatelessWidget {
  const XProductCard({
    super.key,
    required this.product,
  });
  final MProduct product;

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(AppRadius.r8),
      clipBehavior: Clip.hardEdge,
      elevation: AppElevation.ev3,
      child: InkWell(
        child: Ink(
          width: AppSize.s150,
          padding: const EdgeInsets.all(AppPadding.p10),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(AppRadius.r8),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _renderProductImage(),
              _renderProductTitle(context),
              Expanded(child: _renderPrice()),
              _renderProvince(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _renderProductImage() {
    return Image.memory(
      (product.image ?? []).convertToUint8List(),
      fit: BoxFit.cover,
      width: AppSize.s130,
      height: AppSize.s123,
    );
  }

  Widget _renderProductTitle(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            product.title,
            style: AppTextStyle.contentTexStyle.copyWith(
              color: AppColors.black,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _renderPrice() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          Utils.createPriceText(product.price),
          style: AppTextStyle.contentTexStyleBold
              .copyWith(color: AppColors.errorColor),
        ),
      ],
    );
  }

  Widget _renderProvince() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(
          Icons.location_on_rounded,
          color: AppColors.text,
          size: AppSize.s20,
        ),
        Expanded(
          child: Text(
            product.province,
            style: AppTextStyle.contentTexStyle.copyWith(
              fontSize: AppFontSize.f12,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        )
      ],
    );
  }
}
