import 'package:flutter/material.dart';
import 'package:i2hand/gen/assets.gen.dart';
import 'package:i2hand/src/localization/localization_utils.dart';
import 'package:i2hand/src/theme/colors.dart';
import 'package:i2hand/src/theme/styles.dart';
import 'package:i2hand/src/theme/value.dart';
import 'package:i2hand/src/utils/padding_utils.dart';
import 'package:i2hand/widget/button/fill_button.dart';

class XProductCartEdit extends StatelessWidget {
  const XProductCartEdit({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        _renderImageProduct(),
        XPaddingUtils.horizontalPadding(width: AppPadding.p10),
        _renderInfor(context),
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
      child: Stack(
        children: [
          Assets.images.splashLogo.image(
            width: AppSize.s105,
            height: AppSize.s105,
            fit: BoxFit.cover,
          ),
          Positioned(
            bottom: 10,
            left: 6,
            child: _renderRemoveButton(),
          )
        ],
      ),
    );
  }

  Widget _renderInfor(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _renderProductName(context),
          _renderProductPrice(context),
          _renderOptions(context),
        ],
      ),
    );
  }

  Widget _renderProductName(BuildContext context) {
    return Text(
      'Lorem ipsum dolor sit amet consectetur.',
      style: AppTextStyle.contentTexStyle.copyWith(
        color: AppColors.black,
        fontSize: AppFontSize.f12,
      ),
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _renderProductPrice(BuildContext context) {
    return Text(
      '\$17,00',
      style: AppTextStyle.titleTextStyle.copyWith(fontSize: AppFontSize.f18),
    );
  }

  Widget _renderOptions(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _renderAddToCart(context),
      ],
    );
  }

  Widget _renderAddToCart(BuildContext context) {
    return XFillButton(
        label: Text(
      S.of(context).addToCart,
      style: AppTextStyle.buttonTextStylePrimary,
    ));
  }

  Widget _renderRemoveButton() {
    return IconButton.filled(
        color: AppColors.red,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(AppColors.white),
          padding:
              MaterialStateProperty.all(const EdgeInsets.all(AppPadding.p4)),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          minimumSize: MaterialStateProperty.all(Size.zero),
        ),
        onPressed: () {},
        icon: const Icon(Icons.delete_outlined));
  }
}
