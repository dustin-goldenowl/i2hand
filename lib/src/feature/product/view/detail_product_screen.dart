import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i2hand/gen/assets.gen.dart';
import 'package:i2hand/gen/fonts.gen.dart';
import 'package:i2hand/src/feature/product/logic/detail_product_bloc.dart';
import 'package:i2hand/src/feature/product/logic/detail_product_state.dart';
import 'package:i2hand/src/localization/localization_utils.dart';
import 'package:i2hand/src/network/model/user/user.dart';
import 'package:i2hand/src/theme/colors.dart';
import 'package:i2hand/src/theme/decorations.dart';
import 'package:i2hand/src/theme/styles.dart';
import 'package:i2hand/src/theme/value.dart';
import 'package:i2hand/src/utils/padding_utils.dart';
import 'package:i2hand/src/utils/string_ext.dart';
import 'package:i2hand/src/utils/utils.dart';
import 'package:i2hand/widget/avatar/avatar.dart';
import 'package:i2hand/widget/button/fill_button.dart';
import 'package:i2hand/widget/carousel/default_carousel.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({super.key});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  @override
  void initState() {
    super.initState();
    context.read<DetailProductBloc>().initial(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _renderBottomButtonSection(context),
      body: SafeArea(
        child: BlocBuilder<DetailProductBloc, DetailProductState>(
          buildWhen: (pre, cur) => pre.status != cur.status,
          builder: (context, state) {
            if (state.status == DetailProductScreenStatus.loading) {
              return _loadingScreen();
            }
            return CustomScrollView(
              slivers: [
                SliverAppBar(
                  flexibleSpace: FlexibleSpaceBar(
                    background: _renderImageCarousel(),
                    stretchModes: const [StretchMode.zoomBackground],
                  ),
                  backgroundColor: Colors.transparent,
                  pinned: true,
                  expandedHeight: AppSize.s350,
                  stretch: true,
                  elevation: 0,
                  centerTitle: false,
                ),
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: _renderDetailProductSection(context),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _loadingScreen() {
    return Center(
      child: Assets.jsons.syncData
          .lottie(width: AppSize.s220, alignment: Alignment.center),
    );
  }

  Widget _renderImageCarousel() {
    return BlocBuilder<DetailProductBloc, DetailProductState>(
      buildWhen: (previous, current) =>
          previous.assetsStatus != current.assetsStatus ||
          listEquals(previous.listImage, current.listImage),
      builder: (context, state) {
        return state.assetsStatus == FetchAssetsStatus.success ||
                !isNullOrEmpty(state.listImage)
            ? XCarousel(
                height: AppSize.s350,
                isIndicatorInside: true,
                autoPlay: false,
                padBottom: AppSize.s24,
                items: [
                  for (Uint8List? image in state.listImage!)
                    Image.memory(image ?? Uint8List(0))
                ],
              )
            : Assets.jsons.loadingPicture.lottie(fit: BoxFit.contain);
      },
    );
  }

  Widget _renderDetailProductSection(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      width: double.infinity,
      decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(AppRadius.r40),
            topRight: Radius.circular(AppRadius.r40),
          ),
          boxShadow: AppDecorations.shadowReverse),
      padding: const EdgeInsets.symmetric(
          horizontal: AppPadding.p16, vertical: AppPadding.p45),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _renderPrice(context),
          _renderTitleAndSavePost(context),
          _renderUserInfor(context),
          _renderDescription(context),
          _renderDescription(context),
          _renderDescription(context),
          _renderDescription(context),
          _renderDescription(context),
          _renderDescription(context),
          _renderDescription(context),
          _renderDescription(context),
          _renderDescription(context),
        ],
      ),
    );
  }

  Widget _renderTitleAndSavePost(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        _renderTitleText(),
        _renderSavePostButton(),
      ],
    );
  }

  Widget _renderTitleText() {
    return Expanded(
      child: BlocBuilder<DetailProductBloc, DetailProductState>(
        buildWhen: (previous, current) => previous.product != current.product,
        builder: (context, state) {
          return Text(
            state.product.title,
            style: AppTextStyle.titleTextStyle,
          );
        },
      ),
    );
  }

  Widget _renderDescription(BuildContext context) {
    return BlocBuilder<DetailProductBloc, DetailProductState>(
      buildWhen: (previous, current) => previous.product != current.product,
      builder: (context, state) {
        return Text(
          state.product.description,
          style: AppTextStyle.contentTexStyle.copyWith(
            fontSize: AppFontSize.f15,
            color: AppColors.black,
          ),
        );
      },
    );
  }

  Widget _renderPrice(BuildContext context) {
    return BlocBuilder<DetailProductBloc, DetailProductState>(
      buildWhen: (previous, current) => previous.product != current.product,
      builder: (context, state) {
        return Text(
          Utils.createPriceText(state.product.price),
          style: AppTextStyle.contentTexStyleBold.copyWith(
            color: AppColors.errorColor,
            fontSize: AppFontSize.f26,
            fontWeight: FontWeight.w900,
          ),
        );
      },
    );
  }

  Widget _renderBottomButtonSection(BuildContext context) {
    return BlocSelector<DetailProductBloc, DetailProductState,
        DetailProductScreenStatus>(
      selector: (state) {
        return state.status;
      },
      builder: (context, status) {
        return status == DetailProductScreenStatus.loading
            ? const SizedBox.shrink()
            : Container(
                margin: const EdgeInsets.only(
                    bottom: AppMargin.m10,
                    left: AppMargin.m20,
                    right: AppMargin.m20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(AppRadius.r16),
                    color: AppColors.backgroundButton,
                    boxShadow: AppDecorations.shadow
                        .followedBy(AppDecorations.shadowReverse)
                        .toList()),
                padding: const EdgeInsets.all(AppPadding.p8),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    _renderAddCartButton(context),
                    XPaddingUtils.horizontalPadding(width: AppPadding.p16),
                    _renderBuyButton(context),
                  ],
                ),
              );
      },
    );
  }

  Widget _renderAddCartButton(BuildContext context) {
    return Expanded(
      child: XFillButton(
          bgColor: AppColors.black3,
          label: Text(
            S.of(context).addToCart,
            style: AppTextStyle.buttonTextStylePrimary
                .copyWith(color: AppColors.white),
          )),
    );
  }

  Widget _renderBuyButton(BuildContext context) {
    return Expanded(
      child: XFillButton(
          label: Text(
        S.of(context).buyNow,
        style: AppTextStyle.buttonTextStylePrimary,
      )),
    );
  }

  Widget _renderUserInfor(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: AppPadding.p10),
      padding: const EdgeInsets.symmetric(vertical: AppPadding.p10),
      decoration: const BoxDecoration(
        border: Border.symmetric(
          horizontal: BorderSide(width: AppSize.s0_5, color: AppColors.divider),
        ),
      ),
      child: Column(
        children: [
          _renderUser(context),
          _renderUserRate(context),
        ],
      ),
    );
  }

  Widget _renderSavePostButton() {
    return IconButton(
        onPressed: () {
          //TODO: Add logic save post
        },
        icon: const Icon(
          Icons.favorite_border_outlined,
          color: AppColors.errorColor,
        ));
  }

  Widget _renderUser(BuildContext context) {
    return BlocBuilder<DetailProductBloc, DetailProductState>(
      buildWhen: (previous, current) => previous.user != current.user,
      builder: (context, state) {
        return Row(
          children: [
            _renderUserAvatar(
              (isNullOrEmpty(state.user)
                  ? null
                  : (state.user!.avatar ?? []).convertToUint8List()),
            ),
            XPaddingUtils.horizontalPadding(width: AppPadding.p10),
            _renderUserName((state.user ?? MUser.empty()).name ?? ''),
            _renderViewPageButton(context),
          ],
        );
      },
    );
  }

  Widget _renderUserAvatar(Uint8List? memoryImage) {
    return XAvatar(
      imageSize: AppSize.s60,
      memoryData: memoryImage,
      borderColor: AppColors.secondPrimary,
      imageType: memoryImage != null ? ImageType.memory : ImageType.none,
    );
  }

  Widget _renderUserName(String userName) {
    return Expanded(
      child: Text(
        userName,
        style: AppTextStyle.titleTextStyle.copyWith(fontSize: AppFontSize.f18),
      ),
    );
  }

  Widget _renderViewPageButton(BuildContext context) {
    return Material(
      clipBehavior: Clip.hardEdge,
      borderRadius: BorderRadius.circular(AppRadius.r30),
      child: InkWell(
        onTap: () {
          //TODO: Add logic go to user page
        },
        child: Ink(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppRadius.r30),
            border: Border.all(color: AppColors.primary),
          ),
          padding: const EdgeInsets.all(AppPadding.p5),
          child: Text(
            S.of(context).viewPage,
            style: AppTextStyle.labelStyle.copyWith(
              fontFamily: FontFamily.nunitoSans,
              color: AppColors.secondPrimary,
            ),
          ),
        ),
      ),
    );
  }

  Widget _renderUserRate(BuildContext context) {
    // TODO: Add logic fetch user's rate
    return SizedBox(
      height: AppFontSize.f24,
      child: ListView.builder(
          itemCount: 5,
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) => const Icon(
                Icons.star,
                size: AppFontSize.f20,
                color: AppColors.yellowIcon,
              )),
    );
  }
}
