import 'package:flutter/material.dart';

class XIconButton extends StatelessWidget {
  const XIconButton({
    super.key,
    required this.bgColor,
    required this.icon,
    required this.onPressed,
    this.iconSize,
    this.iconColor,
  });
  final Color bgColor;
  final IconData icon;
  final Function onPressed;
  final double? iconSize;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    return IconButton.filled(
      style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(bgColor)),
      onPressed: () => onPressed(),
      icon: Icon(icon),
      iconSize: iconSize,
      color: iconColor,
    );
  }
}
