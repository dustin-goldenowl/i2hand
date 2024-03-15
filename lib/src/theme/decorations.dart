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

  static fullShadow({Color? color}) => [
        BoxShadow(
          offset: const Offset(0, 2),
          blurRadius: 2,
          color: color ?? Colors.black.withOpacity(.1),
        ),
        BoxShadow(
          offset: const Offset(2, 0),
          blurRadius: 2,
          color: color ?? Colors.black.withOpacity(.1),
        ),
        BoxShadow(
          offset: const Offset(0, -2),
          blurRadius: 2,
          color: color ?? Colors.black.withOpacity(.1),
        ),
        BoxShadow(
          offset: const Offset(-2, 0),
          blurRadius: 2,
          color: color ?? Colors.black.withOpacity(.1),
        ),
      ];

  static const InputDecoration inputNoneBorder = InputDecoration(
    border: InputBorder.none,
    enabledBorder: InputBorder.none,
  );
}
