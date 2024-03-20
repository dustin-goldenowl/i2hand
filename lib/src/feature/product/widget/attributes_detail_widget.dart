import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:i2hand/gen/assets.gen.dart';
import 'package:i2hand/src/config/enum/attribute_enum.dart';
import 'package:i2hand/src/localization/localization_utils.dart';
import 'package:i2hand/src/theme/colors.dart';
import 'package:i2hand/src/theme/styles.dart';
import 'package:i2hand/src/theme/value.dart';
import 'package:i2hand/src/utils/padding_utils.dart';

class XAttributesDetailWidget extends StatelessWidget {
  const XAttributesDetailWidget({
    super.key,
    required this.attribute,
    required this.attributeValue,
  });
  final AttributeEnum attribute;
  final String attributeValue;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppPadding.p5),
      child: Row(
        children: [
          _getAttributeIcon(),
          XPaddingUtils.horizontalPadding(width: AppPadding.p5),
          _renderAttributeName(context),
          Text(S.of(context).twoDots, style: AppTextStyle.contentTexStyle),
          _renderAttributeValue(context),
        ],
      ),
    );
  }

  Widget _getAttributeIcon() {
    switch (attribute) {
      case AttributeEnum.status:
        return Assets.svg.icStatus.svg(width: AppSize.s24);
      case AttributeEnum.agencyPhone:
        return Assets.svg.icLaptopAgency.svg(width: AppSize.s24);
      case AttributeEnum.agencyLaptop:
        return Assets.svg.icLaptopAgency.svg(width: AppSize.s24);
      case AttributeEnum.microProcessor:
        return Assets.svg.icMicroprocessor.svg(width: AppSize.s24);
      case AttributeEnum.ram:
        return Assets.svg.icRam.svg(width: AppSize.s24);
      case AttributeEnum.hardWare:
        return Assets.svg.icHardware.svg(width: AppSize.s24);
      case AttributeEnum.hardWareType:
        return Assets.svg.icHardwareType.svg(width: AppSize.s24);
      case AttributeEnum.graphicsCard:
        return Assets.svg.icGraphicsCard.svg(width: AppSize.s24);
      case AttributeEnum.screenSize:
        return Assets.svg.icScreenSize.svg(width: AppSize.s24);
      case AttributeEnum.warrantyPolicy:
        return Assets.svg.icWarranty.svg(width: AppSize.s24);
      case AttributeEnum.origin:
        return Assets.svg.icOrigin.svg(width: AppSize.s24);
      case AttributeEnum.color:
        return Assets.svg.icColor.svg(width: AppSize.s24);
      default:
        return const SizedBox.shrink();
    }
  }

  Widget _renderAttributeName(BuildContext context) {
    return Text(
      attribute.getAttributeText(context),
      style: AppTextStyle.contentTexStyle.copyWith(
        color: AppColors.black,
        fontSize: AppFontSize.f15,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget _renderAttributeValue(BuildContext context) {
    return Text(
      attributeValue,
      style: AppTextStyle.contentTexStyle.copyWith(
        color: AppColors.black,
        fontSize: AppFontSize.f15,
      ),
    );
  }
}
