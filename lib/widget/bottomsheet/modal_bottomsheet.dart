import 'package:flutter/material.dart';
import 'package:i2hand/src/config/enum/options.dart';
import 'package:i2hand/src/localization/localization_utils.dart';
import 'package:i2hand/src/router/coordinator.dart';
import 'package:i2hand/src/theme/colors.dart';
import 'package:i2hand/src/theme/styles.dart';
import 'package:i2hand/src/theme/value.dart';
import 'package:i2hand/src/utils/padding_utils.dart';
import 'package:i2hand/src/utils/string_utils.dart';
import 'package:i2hand/widget/button/fill_button.dart';
import 'package:i2hand/widget/separate/dash_separate.dart';

class XOptionsBottomSheet extends StatefulWidget {
  final String? title;
  final bool isShowButton;
  final List<OptionsEnum> listOptions;
  const XOptionsBottomSheet({
    super.key,
    this.title,
    required this.listOptions,
    this.isShowButton = false,
  });

  @override
  State<XOptionsBottomSheet> createState() => _XOptionsBottomSheetState();
}

class _XOptionsBottomSheetState extends State<XOptionsBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
          child: Container(
        padding: const EdgeInsets.all(AppPadding.p16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _renderTitle(),
            _renderOptions(),
            XPaddingUtils.verticalPadding(height: AppPadding.p30),
            widget.isShowButton == true
                ? _renderSelectButton()
                : const SizedBox.shrink(),
          ],
        ),
      )),
    );
  }

  Widget _renderTitle() {
    return StringUtils.isNullOrEmpty(widget.title)
        ? const SizedBox.shrink()
        : Padding(
            padding: const EdgeInsets.only(bottom: AppPadding.p16),
            child: Text(
              widget.title!,
              style: AppTextStyle.labelStyle,
            ),
          );
  }

  Widget _renderOptions() {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: widget.listOptions.length,
        itemBuilder: (context, index) =>
            _renderOption(index: index, option: widget.listOptions[index]));
  }

  Widget _renderOption({required int index, required OptionsEnum option}) {
    return InkWell(
      onTap: () => AppCoordinator.pop(option),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
                vertical: AppPadding.p16, horizontal: AppPadding.p8),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                    child: Text(
                  option.getOptionsText(context),
                  style: AppTextStyle.contentTexStyle
                      .copyWith(color: AppColors.black),
                )),
              ],
            ),
          ),
          const XDashSeparator(
            height: AppSize.s0_5,
            color: AppColors.grey4,
          )
        ],
      ),
    );
  }

  Widget _renderSelectButton() {
    return XFillButton(
        onPressed: () {
          AppCoordinator.pop();
        },
        label: Text(
          S.of(context).select,
          style: AppTextStyle.buttonTextStylePrimary,
        ));
  }
}
