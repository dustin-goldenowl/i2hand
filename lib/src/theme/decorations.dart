import 'package:flutter/material.dart';

class AppDecorations {
  static final shadow = [
    BoxShadow(
      offset: const Offset(2, 2),
      blurRadius: 2,
      color: Colors.black.withOpacity(.1),
    ),
  ];

  static final shadowTwo = [
    BoxShadow(
      offset: const Offset(0, 3),
      blurRadius: 3,
      color: Colors.black.withOpacity(.1),
    ),
  ];

  static final shadowReverse = [
    BoxShadow(
      offset: const Offset(-2, -2),
      blurRadius: 2,
      color: Colors.black.withOpacity(.1),
    ),
  ];

  static fullShadow({Color? color, double shadowSize = 2}) => [
        BoxShadow(
          offset: Offset(0, shadowSize),
          blurRadius: shadowSize,
          color: color ?? Colors.black.withOpacity(.1),
        ),
        BoxShadow(
          offset: Offset(shadowSize, 0),
          blurRadius: shadowSize,
          color: color ?? Colors.black.withOpacity(.1),
        ),
        BoxShadow(
          offset: Offset(0, -shadowSize),
          blurRadius: shadowSize,
          color: color ?? Colors.black.withOpacity(.1),
        ),
        BoxShadow(
          offset: Offset(-shadowSize, 0),
          blurRadius: shadowSize,
          color: color ?? Colors.black.withOpacity(.1),
        ),
      ];

  static const InputDecoration inputNoneBorder = InputDecoration(
    border: InputBorder.none,
    enabledBorder: InputBorder.none,
  );
}
