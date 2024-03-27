import 'package:flutter/material.dart';
import 'package:i2hand/gen/assets.gen.dart';
import 'package:i2hand/src/theme/colors.dart';
import 'package:i2hand/src/theme/decorations.dart';
import 'package:i2hand/src/theme/styles.dart';
import 'package:i2hand/src/theme/value.dart';
import 'package:i2hand/src/utils/padding_utils.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

enum DialogStatus { loading, succeeded, failed, init }

class XCustomDialog extends StatelessWidget {
  const XCustomDialog({
    super.key,
    this.actions,
    required this.title,
    required this.subTitle,
    required this.status,
  });
  final Widget? actions;
  final String title;
  final String subTitle;
  final DialogStatus status;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppPadding.p23),
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            _renderBackground(),
            _renderHeaderIcon(),
          ],
        ),
      ),
    );
  }

  Widget _renderBackground() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(
        top: AppPadding.p59,
        bottom: AppPadding.p20,
        left: AppPadding.p23,
        right: AppPadding.p23,
      ),
      margin: const EdgeInsets.only(top: AppMargin.m38),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppRadius.r16),
        boxShadow: AppDecorations.fullShadow(),
      ),
      child: _renderBody(),
    );
  }

  Widget _renderHeaderIcon() {
    return Positioned(
      child: Container(
        width: AppSize.s80,
        height: AppSize.s80,
        decoration: BoxDecoration(
          color: AppColors.white,
          border: Border.all(
            color: AppColors.white,
            width: AppSize.s15,
            strokeAlign: BorderSide.strokeAlignCenter,
          ),
          borderRadius: BorderRadius.circular(AppRadius.r40),
          boxShadow: AppDecorations.fullShadow(shadowSize: AppSize.s17),
        ),
        child: _getIconHeader(),
      ),
    );
  }

  Widget _getIconHeader() {
    switch (status) {
      case DialogStatus.loading:
        return LoadingAnimationWidget.inkDrop(
          color: AppColors.primary,
          size: AppSize.s50,
        );
      case DialogStatus.failed:
        return Assets.svg.failedDialog.svg(width: AppSize.s50);
      case DialogStatus.succeeded:
        return Assets.svg.succeededDialog.svg(width: AppSize.s50);
      default:
        return const SizedBox.shrink();
    }
  }

  Widget _renderBody() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _renderTitle(),
        XPaddingUtils.verticalPadding(height: AppPadding.p7),
        _renderSubTitle(),
        XPaddingUtils.verticalPadding(height: AppPadding.p23),
        _renderActions(),
      ],
    );
  }

  Widget _renderTitle() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppPadding.p16),
      child: Text(
        title,
        textAlign: TextAlign.center,
        maxLines: AppLines.l3,
        style: AppTextStyle.titleTextStyle.copyWith(
          fontSize: AppFontSize.f20,
          color: AppColors.text,
        ),
      ),
    );
  }

  Widget _renderSubTitle() {
    return Text(
      subTitle,
      textAlign: TextAlign.center,
      style: AppTextStyle.contentTexStyle.copyWith(
        color: AppColors.black,
        fontSize: AppFontSize.f13,
      ),
    );
  }

  Widget _renderActions() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppPadding.p8),
      child: actions ?? const SizedBox.shrink(),
    );
  }
}
