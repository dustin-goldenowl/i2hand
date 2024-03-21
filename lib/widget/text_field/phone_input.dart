import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:i2hand/src/localization/localization_utils.dart';
import 'package:i2hand/src/network/model/country/country_code.dart';
import 'package:i2hand/src/theme/colors.dart';
import 'package:i2hand/src/theme/styles.dart';
import 'package:i2hand/src/theme/value.dart';
import 'package:i2hand/src/utils/padding_utils.dart';
import 'package:i2hand/src/utils/string_utils.dart';

class XPhoneInput extends StatefulWidget {
  final CountryCode countryCodeDomain;
  final ValueChanged<String> onChangedInput;
  final VoidCallback? onPressCountryFlag;
  final String? label;
  final String? initialValue;
  final String? hintText;
  final String? errorText;
  final TextEditingController? controller;
  final TextInputAction? keyboardAction;
  final ValueChanged<String>? onSubmit;
  final bool isRequired;
  final int? maxlength;
  final bool? isShowLabel;
  final Color fieldColor;

  const XPhoneInput({
    Key? key,
    required this.countryCodeDomain,
    required this.onChangedInput,
    this.onPressCountryFlag,
    this.label,
    this.initialValue,
    this.hintText,
    this.errorText,
    this.controller,
    this.keyboardAction,
    this.onSubmit,
    this.isRequired = false,
    this.maxlength,
    this.isShowLabel = true,
    this.fieldColor = AppColors.grey6,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _InputWidgetState();
}

class _InputWidgetState extends State<XPhoneInput> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _renderLabel(),
        _renderMainView(),
        _renderErrorText(),
      ],
    );
  }

  Widget _renderLabel() {
    return widget.isShowLabel ?? true
        ? Column(
            children: [
              RichText(
                textAlign: TextAlign.start,
                text: TextSpan(
                  text: widget.label ?? S.of(context).yourNumber,
                  style: AppTextStyle.labelStyle,
                  children: [
                    if (widget.isRequired)
                      TextSpan(
                        text: ' *',
                        style: AppTextStyle.labelStyle,
                      ),
                  ],
                ),
              ),
              const SizedBox(height: AppSize.s8),
            ],
          )
        : const SizedBox.shrink();
  }

  Widget _renderMainView() {
    return Container(
      decoration: BoxDecoration(
        color: widget.fieldColor,
        border: Border.all(
          color: widget.errorText == null
              ? Colors.transparent
              : AppColors.errorColor,
          width: AppSize.s1,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(AppRadius.r30)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: AppPadding.p12),
      child: Row(
        children: [
          _renderCountryCodeButton(),
          XPaddingUtils.horizontalPadding(width: AppPadding.p10),
          _renderPhoneInput(),
        ],
      ),
    );
  }

  Widget _renderCountryCodeButton() {
    return GestureDetector(
      onTap: widget.onPressCountryFlag,
      child: Container(
        height: AppSize.s44,
        color: Colors.transparent,
        child: Row(
          children: [
            StringUtils.isNullOrEmpty(widget.countryCodeDomain.flag)
                ? Text(widget.countryCodeDomain.flag ?? '🇺🇸')
                : SvgPicture.network(
                    widget.countryCodeDomain.flag!,
                    width: AppSize.s24,
                  ),
            const SizedBox(width: AppMargin.m4),
            Text('+${widget.countryCodeDomain.dial ?? '1'}'),
            const SizedBox(width: AppMargin.m8),
            if (widget.onPressCountryFlag != null)
              Container(
                  margin: const EdgeInsets.only(right: AppMargin.m8),
                  child: const Icon(
                    Icons.arrow_drop_down,
                    color: AppColors.secondPrimary,
                  )),
            Container(
              height: 24,
              width: 1,
              color: AppColors.secondPrimary,
            ),
          ],
        ),
      ),
    );
  }

  Widget _renderPhoneInput() {
    return Flexible(
      child: TextFormField(
        initialValue: widget.initialValue,
        textDirection: TextDirection.ltr,
        controller: widget.controller,
        keyboardType: TextInputType.phone,
        textInputAction: widget.keyboardAction,
        style: AppTextStyle.hintTextStyle.copyWith(color: AppColors.black),
        onFieldSubmitted: widget.onSubmit,
        cursorColor: AppColors.primary,
        decoration: InputDecoration(
          hintText: widget.hintText,
          hintStyle: AppTextStyle.hintTextStyle
              .copyWith(color: AppColors.secondPrimary),
          errorStyle: const TextStyle(height: 0, fontSize: 0),
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          focusedErrorBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          counterText: '',
        ),
        onChanged: widget.onChangedInput,
        maxLength: widget.maxlength,
      ),
    );
  }

  Widget _renderErrorText() {
    return widget.errorText?.isNotEmpty == true
        ? Container(
            margin: const EdgeInsets.only(top: AppMargin.m8),
            child: Text(
              widget.errorText!,
              style: AppTextStyle.contentTexStyle
                  .copyWith(color: AppColors.errorColor),
            ),
          )
        : const SizedBox(height: AppSize.s24);
  }
}
