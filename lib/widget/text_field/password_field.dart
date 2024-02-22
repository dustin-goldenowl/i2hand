import 'package:flutter/material.dart';
import 'package:i2hand/src/config/constants/app_const.dart';
import 'package:i2hand/src/theme/colors.dart';
import 'package:i2hand/src/theme/value.dart';

class XPasswordField extends StatefulWidget {
  const XPasswordField(
      {super.key,
      required this.passwordLength,
      this.onChangedPassword,
      this.isWrong = false,
      required this.password});
  final int passwordLength;
  final Function(String)? onChangedPassword;
  final String password;
  final bool isWrong;

  @override
  State<XPasswordField> createState() => _XPasswordFieldState();
}

class _XPasswordFieldState extends State<XPasswordField> {
  late TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
    controller.addListener(() {
      if (controller.text.length > AppConstantData.passwordLength) {
        controller.clear();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (int i = 0; i < widget.passwordLength; i++)
          _renderCell(i < widget.password.length)
      ],
    );
  }

  Widget _renderCell(bool isEnter) {
    return Container(
      height: AppSize.s17,
      width: AppSize.s17,
      margin: const EdgeInsets.symmetric(horizontal: AppMargin.m8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSize.s17 / 2),
        color: widget.isWrong
            ? AppColors.errorColor
            : isEnter
                ? AppColors.primary
                : AppColors.backgroundButton,
      ),
      child: TextField(
        onChanged: (value) {
          widget.onChangedPassword?.call(value);
        },
        controller: controller,
        style: const TextStyle(color: Colors.transparent),
        cursorWidth: AppSize.s0,
        keyboardType: TextInputType.number,
        decoration: const InputDecoration(
          border: InputBorder.none,
        ),
        contextMenuBuilder: (context, editableTextState) => const SizedBox(),
        showCursor: false,
        mouseCursor: MouseCursor.defer,
      ),
    );
  }
}
