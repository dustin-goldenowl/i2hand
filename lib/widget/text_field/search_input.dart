import 'package:flutter/material.dart';
import 'package:i2hand/src/theme/styles.dart';
import 'package:i2hand/src/theme/value.dart';

class XSearchInput extends StatefulWidget {
  final Function(String) onChanged;
  final VoidCallback? onPressClearButton;
  final String? placeHolder;
  const XSearchInput({
    Key? key,
    required this.onChanged,
    this.onPressClearButton,
    this.placeHolder,
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
        decoration: InputDecoration(
          hintText: widget.placeHolder ?? 'Search',
          prefixIconConstraints: const BoxConstraints(minWidth: 36),
          prefixIcon: const Icon(Icons.search),
          suffixIconConstraints: const BoxConstraints(minWidth: 36),
          suffixIcon: _renderClearButton(),
          contentPadding: const EdgeInsets.all(0),
        ),
        textInputAction: TextInputAction.done,
        onChanged: widget.onChanged,
      ),
    );
  }

  IconButton? _renderClearButton() {
    return _isShowClearButton
        ? IconButton(
            onPressed: _onPressClearButton,
            icon: const Icon(
              Icons.clear,
              size: AppSize.s20,
            ))
        : null;
  }
}
