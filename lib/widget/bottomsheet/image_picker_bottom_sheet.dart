import 'package:flutter/material.dart';
import 'package:i2hand/src/localization/localization_utils.dart';
import 'package:i2hand/src/theme/colors.dart';
import 'package:i2hand/src/theme/styles.dart';
import 'package:i2hand/src/theme/value.dart';
import 'package:i2hand/src/utils/padding_utils.dart';
import 'package:i2hand/widget/button/fill_button.dart';
import 'package:i2hand/widget/separate/dash_separate.dart';

class XImagePickerBottomSheet extends StatelessWidget {
  final bool isPhotoExisted;
  final Function? onSelectedValue;
  final String? title;
  final List listOptionsEnum;

  const XImagePickerBottomSheet(
      {Key? key,
      required this.isPhotoExisted,
      required this.onSelectedValue,
      required this.listOptionsEnum,
      this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final options = listOptionsEnum;
    var listOptions = options.take(100).toList();
    if (!isPhotoExisted) {
      listOptions.removeLast();
    }
    return Material(
      child: SafeArea(
        child: Container(
          margin: const EdgeInsets.only(top: AppMargin.m20),
          padding: const EdgeInsets.symmetric(horizontal: AppPadding.p16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title ?? S.of(context).editProfilePicture,
                style: AppTextStyle.titleTextStyle
                    .copyWith(fontSize: AppFontSize.f20),
              ),
              XPaddingUtils.verticalPadding(height: AppPadding.p16),
              ConstrainedBox(
                constraints: const BoxConstraints(maxHeight: 400),
                child: ListView.separated(
                  shrinkWrap: true,
                  itemBuilder: (context, index) =>
                      _renderCell(context, value: listOptions[index]),
                  itemCount: listOptions.length,
                  separatorBuilder: (context, index) {
                    return const XDashSeparator(
                      color: AppColors.text,
                      height: AppSize.s0_5,
                    );
                  },
                ),
              ),
              Container(
                  margin: const EdgeInsets.only(
                    top: AppMargin.m16,
                    bottom: AppMargin.m20,
                  ),
                  width: double.infinity,
                  child: XFillButton(
                      label: Text(
                    S.of(context).cancel,
                    style: AppTextStyle.buttonTextStylePrimary,
                  ))),
            ],
          ),
        ),
      ),
    );
  }

  Widget _renderCell(BuildContext context, {required value}) {
    return ListTile(
      title: Text(value.getText(context), style: AppTextStyle.labelStyle),
      onTap: () {
        onSelectedValue?.call(value);
      },
      contentPadding: const EdgeInsets.symmetric(horizontal: AppPadding.p15),
    );
  }
}
