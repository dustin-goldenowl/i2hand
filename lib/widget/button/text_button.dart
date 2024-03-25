import 'package:flutter/material.dart';
import 'package:i2hand/src/theme/value.dart';

class XTextButton extends StatelessWidget {
  const XTextButton({super.key, required this.text, required this.onPressed});
  final Widget text;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => onPressed.call(),
      style: const ButtonStyle(
        padding: MaterialStatePropertyAll(
            EdgeInsets.symmetric(horizontal: AppPadding.p10)),
        minimumSize: MaterialStatePropertyAll(Size.zero),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      child: text,
    );
  }
}
