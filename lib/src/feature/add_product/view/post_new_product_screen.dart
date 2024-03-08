import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:i2hand/package/dismiss_keyboard/dismiss_keyboard.dart';
import 'package:i2hand/src/localization/localization_utils.dart';
import 'package:i2hand/src/router/coordinator.dart';
import 'package:i2hand/src/theme/colors.dart';
import 'package:i2hand/src/theme/styles.dart';
import 'package:i2hand/src/theme/value.dart';
import 'package:i2hand/src/utils/padding_utils.dart';
import 'package:i2hand/widget/appbar/app_bar.dart';
import 'package:i2hand/widget/button/fill_button.dart';
import 'package:i2hand/widget/text_field/dropdown_text_field.dart';
import 'package:i2hand/widget/text_field/textfield_label_inside.dart';

class PostNewProductScreen extends StatefulWidget {
  const PostNewProductScreen({super.key});

  @override
  State<PostNewProductScreen> createState() => _PostNewProductScreenState();
}

class _PostNewProductScreenState extends State<PostNewProductScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: DismissKeyBoard(
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                _renderAppBar(),
                _renderSelectedCategorySection(context),
                _renderDetailInformationSection(context),
                _renderPostInformationSection(context),
                _renderSellerInformationSection(context),
                _renderBottomButton(context),
                XPaddingUtils.verticalPadding(height: AppPadding.p30),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _renderAppBar() {
    return XAppBar(
        titlePage: S.of(context).newPost,
        actions: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            IconButton(
              onPressed: () => AppCoordinator.pop(),
              icon: const Icon(Icons.clear),
            )
          ],
        ));
  }

  Widget _renderSelectedCategorySection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          left: AppPadding.p15, right: AppPadding.p15, bottom: AppPadding.p10),
      child: XDropdownTextField(
        label: S.of(context).categories,
        isRequired: true,
        value: 'Laptop',
      ),
    );
  }

  Widget _renderDetailInformationSection(BuildContext context) {
    return Column(
      children: [
        _renderTitleText(context, title: S.of(context).detailInfor),
        _renderAssetsSection(context),
        _renderListAttributes(context),
      ],
    );
  }

  Widget _renderTitleText(BuildContext context, {required String title}) {
    return Container(
      width: double.infinity,
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(
          horizontal: AppPadding.p15, vertical: AppPadding.p20),
      color: AppColors.grey7,
      child: Text(
        title.toUpperCase(),
        style: AppTextStyle.contentTexStyleBold,
      ),
    );
  }

  Widget _renderListAttributes(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppPadding.p15),
      child: Column(
        children: [
          XPaddingUtils.verticalPadding(height: AppPadding.p10),
          XDropdownTextField(
            label: S.of(context).status,
            isRequired: true,
          ),
          XPaddingUtils.verticalPadding(height: AppPadding.p10),
          XDropdownTextField(
            label: S.of(context).agency,
            isRequired: true,
          ),
          XPaddingUtils.verticalPadding(height: AppPadding.p10),
          XDropdownTextField(
            label: S.of(context).screenSize,
          ),
          XPaddingUtils.verticalPadding(height: AppPadding.p10),
          XDropdownTextField(
            label: S.of(context).price,
            isRequired: true,
          ),
          XPaddingUtils.verticalPadding(height: AppPadding.p10),
        ],
      ),
    );
  }

  Widget _renderAssetsSection(BuildContext context) {
    return Column(
      children: [
        _renderImageSection(context),
        _renderVideoSection(context),
      ],
    );
  }

  Widget _renderImageSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: AppPadding.p15, vertical: AppPadding.p10),
      child: DottedBorder(
        color: AppColors.black2,
        borderType: BorderType.RRect,
        padding: EdgeInsets.zero,
        radius: const Radius.circular(AppRadius.r10),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: AppPadding.p23),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppRadius.r10),
            color: AppColors.backgroundButton,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              const Icon(
                Icons.camera_alt_rounded,
                color: AppColors.primary,
                size: AppSize.s30,
              ),
              Text(
                S.of(context).add1to6picture,
                style: AppTextStyle.titleTextStyle.copyWith(
                  fontSize: AppFontSize.f14,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _renderVideoSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppPadding.p15),
      child: DottedBorder(
        color: AppColors.black2,
        borderType: BorderType.RRect,
        padding: EdgeInsets.zero,
        radius: const Radius.circular(AppRadius.r10),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: AppPadding.p23),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppRadius.r10),
            color: AppColors.backgroundButton,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              const Icon(
                Icons.video_camera_back_rounded,
                color: AppColors.primary,
                size: AppSize.s30,
              ),
              Text(
                S.of(context).addMaximum1Video,
                style: AppTextStyle.titleTextStyle.copyWith(
                  fontSize: AppFontSize.f14,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _renderPostInformationSection(BuildContext context) {
    return Column(
      children: [
        _renderTitleText(context, title: S.of(context).postInfor),
        _renderPostInforTextField(
          context,
          hintText: S.of(context).postTitle,
          label: S.of(context).postTitle,
          isRequired: true,
        ),
        _renderPostInforTextField(
          context,
          hintText: S.of(context).productOriginAndCondition,
          label: S.of(context).description,
          isRequired: true,
          maxLines: 10,
          hintMaxLines: 10,
        ),
      ],
    );
  }

  Widget _renderPostInforTextField(
    BuildContext context, {
    required String label,
    required String hintText,
    bool isRequired = false,
    int? maxLines,
    int? hintMaxLines,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppPadding.p15,
        vertical: AppPadding.p10,
      ),
      child: XTextFieldInsideLabel(
        label: label,
        onChanged: (text) {},
        maxLines: maxLines ?? 1,
        hintMaxLines: hintMaxLines ?? 1,
        isRequired: isRequired,
        hintText: hintText,
      ),
    );
  }

  Widget _renderSellerInformationSection(BuildContext context) {
    return Column(
      children: [
        _renderTitleText(context, title: S.of(context).sellerInfor),
        _renderSellerAddress(context),
      ],
    );
  }

  Widget _renderSellerAddress(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppPadding.p15,
        vertical: AppPadding.p10,
      ),
      child: XDropdownTextField(
        label: S.of(context).address,
        isRequired: true,
      ),
    );
  }

  Widget _renderBottomButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppPadding.p15,
        vertical: AppPadding.p5,
      ),
      child: XFillButton(
          label: Text(
        S.of(context).post,
        style: AppTextStyle.buttonTextStylePrimary,
      )),
    );
  }
}
