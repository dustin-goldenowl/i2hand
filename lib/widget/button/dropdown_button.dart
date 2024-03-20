import 'package:flutter/material.dart';
import 'package:i2hand/src/theme/colors.dart';
import 'package:i2hand/src/theme/styles.dart';
import 'package:i2hand/src/theme/value.dart';

class XDropdownButton extends StatefulWidget {
  const XDropdownButton({
    super.key,
    required this.label,
    required this.expandWidget,
  });
  final String label;
  final Widget expandWidget;

  @override
  State<XDropdownButton> createState() => _XDropdownButtonState();
}

class _XDropdownButtonState extends State<XDropdownButton> {
  bool _isExpand = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          _renderHeader(context),
          _renderHiddenBody(context),
          _renderDivider(),
        ],
      ),
    );
  }

  Widget _renderHeader(BuildContext context) {
    return Row(
      children: [
        _renderTitle(),
        _renderExpandButton(),
      ],
    );
  }

  Widget _renderTitle() {
    return Expanded(
      child: Text(
        widget.label,
        style: AppTextStyle.labelStyle.copyWith(fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _renderExpandButton() {
    return IconButton(
      onPressed: () {
        setState(() {
          _isExpand = !_isExpand;
        });
      },
      icon: Icon(
        _isExpand
            ? Icons.keyboard_arrow_up_rounded
            : Icons.keyboard_arrow_down_rounded,
      ),
    );
  }

  Widget _renderDivider() {
    return const Divider(
      color: AppColors.grey6,
      height: AppSize.s0_5,
    );
  }

  Widget _renderHiddenBody(BuildContext context) {
    return AnimatedCrossFade(
      firstChild: const SizedBox.shrink(),
      secondChild: widget.expandWidget,
      crossFadeState:
          _isExpand ? CrossFadeState.showSecond : CrossFadeState.showFirst,
      duration: const Duration(milliseconds: 300),
    );
  }
}
