import 'package:flutter/material.dart';
import 'package:i2hand/src/theme/colors.dart';
import 'package:i2hand/src/theme/styles.dart';
import 'package:i2hand/src/theme/value.dart';
import 'package:i2hand/src/utils/string_utils.dart';

class XTextField extends StatefulWidget {
  const XTextField({
    super.key,
    this.label,
    this.labelStyle,
    required this.hintText,
    this.hintStyle,
    this.errorText,
    this.initText,
    this.isObscureText = false,
    this.errorStyle,
    this.prefix,
    this.suffix,
    this.radius = AppRadius.r10,
    this.borderColor = AppColors.hintTextColor,
    required this.onChanged,
    this.keyboardType,
    this.isEnable = true,
    this.maxLines = 1,
    this.minLines = 1,
    this.textInputAction,
    this.cursolHeight,
    this.cursorColor,
    this.filledColor = AppColors.grey8,
  });
  final String? label;
  final TextStyle? labelStyle;
  final String hintText;
  final String? initText;
  final TextStyle? hintStyle;
  final String? errorText;
  final TextStyle? errorStyle;
  final Widget? prefix;
  final Widget? suffix;
  final double radius;
  final Color borderColor;
  final bool isObscureText;
  final TextInputType? keyboardType;
  final bool isEnable;
  final void Function(String) onChanged;
  final int maxLines;
  final int minLines;
  final TextInputAction? textInputAction;
  final double? cursolHeight;
  final Color? cursorColor;
  final Color? filledColor;

  @override
  State<XTextField> createState() => _XTextFieldState();
}

class _XTextFieldState extends State<XTextField> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initText);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        StringUtils.isNullOrEmpty(widget.label)
            ? const SizedBox.shrink()
            : Text(widget.label!,
                style: widget.labelStyle ?? AppTextStyle.labelStyle),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: AppPadding.p10),
          child: TextField(
            enabled: widget.isEnable,
            style: AppTextStyle.hintTextStyle.copyWith(color: AppColors.black),
            maxLines: widget.maxLines,
            minLines: widget.minLines,
            cursorColor: widget.cursorColor,
            cursorHeight: widget.cursolHeight,
            keyboardType: widget.keyboardType,
            textInputAction: widget.textInputAction,
            onChanged: (value) => widget.onChanged(value),
            obscureText: widget.isObscureText,
            controller: _controller,
            decoration: InputDecoration(
                fillColor: widget.filledColor,
                filled: true,
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: widget.borderColor, width: 0.5),
                  borderRadius: BorderRadius.circular(widget.radius),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide:
                      const BorderSide(color: AppColors.primary, width: 0.5),
                  borderRadius: BorderRadius.circular(widget.radius),
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: widget.borderColor, width: 0.5),
                  borderRadius: BorderRadius.circular(widget.radius),
                ),
                prefixIcon: widget.prefix,
                suffixIcon: widget.suffix,
                hintText: widget.hintText,
                hintStyle: widget.hintStyle ?? AppTextStyle.hintTextStyle,
                errorText: widget.errorText,
                errorStyle: widget.errorStyle ??
                    AppTextStyle.hintTextStyle.copyWith(color: AppColors.red),
                focusColor: AppColors.primary,
                contentPadding: const EdgeInsets.symmetric(
                    horizontal: AppPadding.p20, vertical: AppPadding.p10)),
          ),
        )
      ],
    );
  }
}
