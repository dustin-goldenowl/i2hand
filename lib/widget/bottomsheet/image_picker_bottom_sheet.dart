import 'package:flutter/material.dart';
import 'package:i2hand/src/config/enum/picture_options_enum.dart';
import 'package:i2hand/src/localization/localization_utils.dart';
import 'package:i2hand/src/theme/styles.dart';
import 'package:i2hand/src/theme/value.dart';
import 'package:i2hand/src/utils/padding_utils.dart';
import 'package:i2hand/widget/button/fill_button.dart';
import 'package:i2hand/widget/separate/dash_separate.dart';

class XImagePickerBottomSheet extends StatelessWidget {
  List<PictureOptionsEnum> _getOptions(BuildContext context) =>
      PictureOptionsEnum.values;

  final bool isPhotoExisted;
  final Function? onSelectedValue;

  const XImagePickerBottomSheet(
      {Key? key, required this.isPhotoExisted, required this.onSelectedValue})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final options = _getOptions(context);
    if (!isPhotoExisted) {
      options.removeLast();
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
                S.of(context).editProfilePicture,
                style: AppTextStyle.titleTextStyle
                    .copyWith(fontSize: AppFontSize.f20),
              ),
              XPaddingUtils.verticalPadding(height: AppPadding.p16),
              ConstrainedBox(
                constraints: const BoxConstraints(maxHeight: 400),
                child: ListView.separated(
                  shrinkWrap: true,
                  itemBuilder: (context, index) =>
                      _renderCell(context, value: options[index]),
                  itemCount: options.length,
                  separatorBuilder: (context, index) {
                    return const XDashSeparator();
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

  Widget _renderCell(BuildContext context,
      {required PictureOptionsEnum value}) {
    return ListTile(
      title: Text(value.getText(context), style: AppTextStyle.labelStyle),
      onTap: () {
        onSelectedValue?.call(value);
      },
      contentPadding: const EdgeInsets.symmetric(horizontal: AppPadding.p15),
    );
  }
}
