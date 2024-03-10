import 'package:flutter/material.dart';
import 'package:i2hand/src/config/enum/attribute_enum.dart';
import 'package:i2hand/src/localization/localization_utils.dart';
import 'package:i2hand/src/theme/colors.dart';
import 'package:i2hand/src/theme/styles.dart';
import 'package:i2hand/src/theme/value.dart';

class XAttributeField extends StatelessWidget {
  const XAttributeField({
    super.key,
    required this.attribute,
    this.isRequired = false,
    required this.onChangedAttribute,
    required this.onChangedAttributeRequired,
    required this.onDeleteAttribute,
    required this.items,
  });
  final AttributeEnum attribute;
  final bool isRequired;
  final Function(AttributeEnum?) onChangedAttribute;
  final Function(bool) onChangedAttributeRequired;
  final Function(AttributeEnum) onDeleteAttribute;
  final List<DropdownMenuItem<AttributeEnum>> items;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        _renderDeleteButton(),
        _renderAttributeField(context),
        _renderIsRequiredCheckBox(context),
      ],
    );
  }

  Widget _renderAttributeField(BuildContext context) {
    return Expanded(
      child: DropdownButtonFormField(
        items: items,
        value: attribute,
        onChanged: (value) => onChangedAttribute(value),
        isExpanded: true,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppRadius.r8),
            borderSide: const BorderSide(
              color: AppColors.black,
              width: AppSize.s0_5,
            ),
          ),
        ),
      ),
    );
  }

  Widget _renderIsRequiredCheckBox(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          value: isRequired,
          onChanged: (value) {
            onChangedAttributeRequired(value ?? false);
          },
        ),
        Text(
          S.of(context).isRequired,
          style: AppTextStyle.contentTexStyle,
        )
      ],
    );
  }

  Widget _renderDeleteButton() {
    return IconButton(
        onPressed: () => onDeleteAttribute(attribute),
        icon: const Icon(
          Icons.remove_circle_outline,
          color: AppColors.errorColor,
        ));
  }
}
