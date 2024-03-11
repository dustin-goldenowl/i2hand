import 'package:flutter/material.dart';
import 'package:i2hand/src/network/model/product/product.dart';
import 'package:i2hand/src/theme/colors.dart';
import 'package:i2hand/src/theme/styles.dart';
import 'package:i2hand/src/theme/value.dart';
import 'package:i2hand/src/utils/padding_utils.dart';
import 'package:i2hand/src/utils/string_ext.dart';
import 'package:i2hand/src/utils/utils.dart';

class XProductCardLarge extends StatelessWidget {
  const XProductCardLarge({
    super.key,
    required this.product,
  });
  final MProduct product;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.transparent,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _renderProductImage(),
          XPaddingUtils.verticalPadding(height: AppPadding.p10),
          _renderProductTitle(context),
          _renderPrice(),
        ],
      ),
    );
  }

  Widget _renderProductImage() {
    return Material(
      elevation: AppElevation.ev12,
      child: Container(
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppRadius.r10),
          border: Border.all(
            width: AppSize.s5,
            color: AppColors.white,
            strokeAlign: BorderSide.strokeAlignOutside,
          ),
        ),
        child: Image.memory(
          (product.image ?? []).convertToUint8List(),
          fit: BoxFit.cover,
          height: AppSize.s170,
        ),
      ),
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
              fontSize: AppFontSize.f12,
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
          style: AppTextStyle.titleTextStyle.copyWith(
            color: AppColors.black,
            fontSize: AppFontSize.f18,
          ),
        ),
      ],
    );
  }
}
