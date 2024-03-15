import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i2hand/package/dismiss_keyboard/dismiss_keyboard.dart';
import 'package:i2hand/src/dialog/toast_wrapper.dart';
import 'package:i2hand/src/feature/add_product/logic/add_product_bloc.dart';
import 'package:i2hand/src/feature/add_product/logic/add_product_state.dart';
import 'package:i2hand/src/localization/localization_utils.dart';
import 'package:i2hand/src/router/coordinator.dart';
import 'package:i2hand/src/theme/colors.dart';
import 'package:i2hand/src/theme/styles.dart';
import 'package:i2hand/src/theme/value.dart';
import 'package:i2hand/src/utils/padding_utils.dart';
import 'package:i2hand/src/utils/string_ext.dart';
import 'package:i2hand/src/utils/string_utils.dart';
import 'package:i2hand/src/utils/utils.dart';
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
    return PopScope(
      onPopInvoked: (didPop) => XToast.hideLoading(),
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: DismissKeyBoard(
          child: BlocListener<AddProductBloc, AddProductState>(
            listener: (context, state) {
              switch (state.status) {
                case AddProductStatus.loading:
                  XToast.showLoading();
                  break;
                case AddProductStatus.fail:
                  XToast.hideLoading();
                  XToast.error(S.of(context).someThingWentWrong);
                  context.read<AddProductBloc>().resetStatus();
                  break;
                case AddProductStatus.success:
                  XToast.hideLoading();
                  AppCoordinator.pop();
                  break;
                default:
                  break;
              }
            },
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
    return BlocBuilder<AddProductBloc, AddProductState>(
      buildWhen: (pre, cur) => pre.selectedCategory != cur.selectedCategory,
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.only(
              left: AppPadding.p15,
              right: AppPadding.p15,
              bottom: AppPadding.p10),
          child: XDropdownTextField(
            label: S.of(context).categories,
            isRequired: true,
            value: state.selectedCategory.name,
            onTap: () => context.read<AddProductBloc>().showSelectedPage(
                  selectedValue: state.selectedCategory.name,
                  attributeName: S.of(context).categories,
                  isSelectCategory: true,
                ),
          ),
        );
      },
    );
  }

  Widget _renderDetailInformationSection(BuildContext context) {
    return Column(
      children: [
        _renderTitleText(context, title: S.of(context).detailInfor),
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
    return BlocBuilder<AddProductBloc, AddProductState>(
      buildWhen: (previous, current) {
        return previous.selectedCategory != current.selectedCategory ||
            !mapEquals(previous.attributesData, current.attributesData);
      },
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppPadding.p15),
          child: Column(
            children: getListAttributes(
              context,
              listAttributeNames: state.selectedCategory.attributes,
              attributesData: state.attributesData,
            ),
          ),
        );
      },
    );
  }

  List<Widget> getListAttributes(
    BuildContext context, {
    required List<String> listAttributeNames,
    required Map<String, String> attributesData,
  }) {
    List<Widget> listAttributes = [];
    for (String attributeName in listAttributeNames) {
      switch (attributeName) {
        case 'images':
          listAttributes.add(_renderImageSection(context));
        case 'videos':
          listAttributes.add(_renderVideoSection(context));
        case 'price':
          listAttributes
              .add(XPaddingUtils.verticalPadding(height: AppPadding.p10));
          listAttributes.add(XTextFieldInsideLabel(
            isRequired: true,
            label: attributeName.capitalizeEachText(),
            onChanged: (price) =>
                context.read<AddProductBloc>().onChangedPrice(price),
            hintText: S.of(context).price.capitalize(),
          ));
          listAttributes
              .add(XPaddingUtils.verticalPadding(height: AppPadding.p10));
        default:
          listAttributes.add(
            Padding(
              padding: const EdgeInsets.symmetric(vertical: AppPadding.p5),
              child: XDropdownTextField(
                label: attributeName.capitalizeEachText(),
                isRequired: true,
                value: attributesData[attributeName.toLowerCase()],
                onTap: () => context.read<AddProductBloc>().showSelectedPage(
                      selectedValue:
                          attributesData[attributeName.toLowerCase()] ?? '1',
                      attributeName: attributeName,
                    ),
              ),
            ),
          );
      }
    }
    return listAttributes;
  }

  Widget _renderImageSection(BuildContext context) {
    return BlocBuilder<AddProductBloc, AddProductState>(
      buildWhen: (previous, current) =>
          !listEquals(previous.listImage, current.listImage),
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: AppPadding.p15, vertical: AppPadding.p10),
          child: isNullOrEmpty(state.listImage)
              ? _renderEmptyImageSection(context)
              : _renderHasImageSection(context, listImage: state.listImage!),
        );
      },
    );
  }

  Widget _renderEmptyImageSection(BuildContext context) {
    return GestureDetector(
      onTap: () => context.read<AddProductBloc>().onTapAddImage(context),
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

  Widget _renderHasImageSection(context, {required List<Uint8List> listImage}) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _renderAttributeLabel(label: S.of(context).images),
          XPaddingUtils.verticalPadding(height: AppPadding.p2),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: _renderListImage(listImage),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _renderListImage(List<Uint8List> listImage) {
    List<Widget> listImageWidget = [];
    listImageWidget.add(_renderAddMoreImage(context));
    for (Uint8List image in listImage) {
      listImageWidget.add(
        _renderImage(image),
      );
    }
    return listImageWidget;
  }

  Widget _renderImage(Uint8List image) {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: AppPadding.p5),
        padding: const EdgeInsets.only(top: AppPadding.p6),
        child: Stack(
          fit: StackFit.passthrough,
          clipBehavior: Clip.none,
          children: [
            Container(
              width: AppSize.s90,
              height: AppSize.s90,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppRadius.r8),
              ),
              clipBehavior: Clip.hardEdge,
              child: Image.memory(image),
            ),
            _renderRemoveImageIcon(image),
          ],
        ));
  }

  Widget _renderRemoveImageIcon(Uint8List image) {
    return Positioned(
      top: -5,
      right: -5,
      child: IconButton.filled(
        onPressed: () => context.read<AddProductBloc>().removeImage(image),
        icon: const Icon(Icons.clear),
        iconSize: AppSize.s14,
        color: AppColors.white,
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(
              AppColors.black3.withOpacity(AppOpacity.o05),
            ),
            padding:
                MaterialStateProperty.all(const EdgeInsets.all(AppPadding.p4)),
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            minimumSize: MaterialStateProperty.all(Size.zero)),
      ),
    );
  }

  Widget _renderAddMoreImage(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: AppPadding.p4),
      margin: const EdgeInsets.only(left: AppMargin.m2, right: AppMargin.m4),
      child: GestureDetector(
        onTap: () => context.read<AddProductBloc>().onTapAddImage(context),
        child: DottedBorder(
          color: AppColors.black2,
          borderType: BorderType.RRect,
          padding: EdgeInsets.zero,
          radius: const Radius.circular(AppRadius.r10),
          child: Container(
            width: AppSize.s90,
            height: AppSize.s90,
            padding: const EdgeInsets.symmetric(vertical: AppPadding.p23),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppRadius.r10),
              color: AppColors.backgroundButton,
            ),
            child: const Center(
              child: Icon(
                Icons.camera_alt_rounded,
                color: AppColors.primary,
                size: AppSize.s30,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _renderVideoSection(BuildContext context) {
    return BlocBuilder<AddProductBloc, AddProductState>(
      buildWhen: (previous, current) =>
          previous.videoThumbnail != current.videoThumbnail,
      builder: (context, state) {
        return isNullOrEmpty(state.videoThumbnail)
            ? _renderEmptyVideoSection(context)
            : _renderHasVideoSection(context,
                videoThumbnail: state.videoThumbnail!);
      },
    );
  }

  Widget _renderEmptyVideoSection(BuildContext context) {
    return GestureDetector(
      onTap: () => context.read<AddProductBloc>().onTapAddVideo(context),
      child: Padding(
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
      ),
    );
  }

  Widget _renderHasVideoSection(BuildContext context,
      {required Uint8List videoThumbnail}) {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: AppPadding.p5),
        padding: const EdgeInsets.only(top: AppPadding.p6),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _renderAttributeLabel(label: S.of(context).videos),
            XPaddingUtils.verticalPadding(height: AppPadding.p2),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
                  fit: StackFit.passthrough,
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      width: AppSize.s90,
                      height: AppSize.s90,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(AppRadius.r8),
                      ),
                      clipBehavior: Clip.hardEdge,
                      child: Image.memory(videoThumbnail),
                    ),
                    _renderForeground(),
                    _renderRemoveImageIcon(videoThumbnail),
                  ],
                ),
              ],
            ),
          ],
        ));
  }

  Widget _renderAttributeLabel({required String label}) {
    return Text(
      label,
      style: AppTextStyle.labelStyle.copyWith(fontWeight: FontWeight.bold),
    );
  }

  Widget _renderForeground() {
    return Positioned.fill(
      child: Container(
        color: AppColors.black2.withOpacity(0.2),
        child: Center(
          child: IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.play_circle,
              color: AppColors.white,
            ),
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
          onChanged: (title) => context.read<AddProductBloc>().setTitle(title),
        ),
        _renderPostInforTextField(
          context,
          hintText: S.of(context).productOriginAndCondition,
          label: S.of(context).description,
          isRequired: true,
          maxLines: 10,
          hintMaxLines: 10,
          onChanged: (des) =>
              context.read<AddProductBloc>().setDescription(des),
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
    required Function(String) onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppPadding.p15,
        vertical: AppPadding.p10,
      ),
      child: XTextFieldInsideLabel(
        label: label,
        onChanged: (text) => onChanged(text),
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
    return BlocBuilder<AddProductBloc, AddProductState>(
      buildWhen: (previous, current) => previous.address != current.address,
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppPadding.p15,
            vertical: AppPadding.p10,
          ),
          child: XDropdownTextField(
            label: S.of(context).address,
            isRequired: true,
            value: StringUtils.getAddressText(rawAddress: state.address),
            onTap: () =>
                context.read<AddProductBloc>().showSelectedAddressPage(context),
          ),
        );
      },
    );
  }

  Widget _renderBottomButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppPadding.p15,
        vertical: AppPadding.p5,
      ),
      child: XFillButton(
          onPressed: () => context.read<AddProductBloc>().postProduct(),
          label: Text(
            S.of(context).post,
            style: AppTextStyle.buttonTextStylePrimary,
          )),
    );
  }
}
