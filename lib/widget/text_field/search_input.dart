import 'package:flutter/material.dart';
import 'package:i2hand/src/localization/localization_utils.dart';
import 'package:i2hand/src/theme/colors.dart';
import 'package:i2hand/src/theme/styles.dart';
import 'package:i2hand/src/theme/value.dart';

class XSearchInput extends StatefulWidget {
  final Function(String) onChanged;
  final VoidCallback? onPressClearButton;
  final String? placeHolder;
  final Widget? prefix;
  final Widget? suffix;
  final InputBorder? border;
  final InputBorder? focusBorder;
  final Color? bgColor;
  const XSearchInput({
    Key? key,
    required this.onChanged,
    this.onPressClearButton,
    this.placeHolder,
    this.prefix,
    this.suffix,
    this.border,
    this.bgColor,
    this.focusBorder,
  }) : super(key: key);

  @override
  State<XSearchInput> createState() => _XSearchInputState();
}

class _XSearchInputState extends State<XSearchInput> {
  final _focusNode = FocusNode();
  final _controller = TextEditingController();
  var _isFocus = false;
  var _isShowClearButton = false;

  @override
  void initState() {
    _focusNode.addListener(() {
      setState(() {
        _isFocus = _focusNode.hasFocus;
      });
    });
    _controller.addListener(() {
      setState(() {
        _isShowClearButton = _isFocus && _controller.text.isNotEmpty;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _controller.dispose();
    super.dispose();
  }

  void _onPressClearButton() {
    _controller.clear();
    if (widget.onPressClearButton != null) {
      widget.onPressClearButton!();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Focus(
      focusNode: _focusNode,
      child: TextFormField(
        controller: _controller,
        style: AppTextStyle.contentTexStyle,
        cursorColor: AppColors.primary,
        decoration: InputDecoration(
          fillColor: widget.bgColor,
          filled: true,
          hintText: widget.placeHolder ?? S.of(context).search,
          hintStyle: AppTextStyle.hintTextStyle.copyWith(
            color: AppColors.grey4,
          ),
          suffixIcon: _renderClearButton(),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: AppPadding.p10),
          prefix: widget.prefix,
          suffix: widget.suffix,
          border: widget.border,
          focusedBorder: widget.focusBorder,
          enabledBorder: widget.border,
        ),
        textInputAction: TextInputAction.done,
        onChanged: widget.onChanged,
      ),
    );
  }

  Widget? _renderClearButton() {
    return _isShowClearButton
        ? IconButton(
            onPressed: _onPressClearButton,
            style: ButtonStyle(
              padding: MaterialStateProperty.all(EdgeInsets.zero),
              minimumSize: MaterialStateProperty.all(Size.zero),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            icon: const Icon(
              Icons.clear,
              size: AppSize.s20,
              color: AppColors.primary,
            ))
        : null;
  }
}
