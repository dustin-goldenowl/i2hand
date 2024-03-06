import 'package:flutter/material.dart';
import 'package:i2hand/gen/assets.gen.dart';
import 'package:i2hand/src/localization/localization_utils.dart';
import 'package:i2hand/src/theme/colors.dart';
import 'package:i2hand/src/theme/decorations.dart';
import 'package:i2hand/src/theme/styles.dart';
import 'package:i2hand/src/theme/value.dart';
import 'package:i2hand/src/utils/padding_utils.dart';
import 'package:i2hand/widget/appbar/app_bar.dart';
import 'package:i2hand/widget/avatar/avatar.dart';
import 'package:i2hand/widget/card/product_card_edit.dart';
import 'package:i2hand/widget/container/circle_empty_container.dart';

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({super.key});

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _renderAppBar(context),
              _renderRecentlyViewSection(context),
              _renderEmptyFavoritedProduct(context),
              _renderListFavoritedProducts(context),
              _renderMostViewedProductSection(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _renderAppBar(BuildContext context) {
    return XAppBar(
      titlePage: S.of(context).wishlist,
    );
  }

  Widget _renderTitleText(BuildContext context,
      {required String title, Widget? action}) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style:
                AppTextStyle.titleTextStyle.copyWith(fontSize: AppFontSize.f21),
          ),
        ),
        action ?? const SizedBox.shrink()
      ],
    );
  }

  Widget _renderMostViewedProductSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppPadding.p20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          _renderTitleText(context, title: S.of(context).mostViewesProduct),
          XPaddingUtils.verticalPadding(height: AppPadding.p10),
          _renderListMostViewedItems(context),
        ],
      ),
    );
  }

  Widget _renderListMostViewedItems(BuildContext context) {
    return SizedBox(
        height: AppSize.s250,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 1,
          itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: AppPadding.p12, vertical: AppPadding.p6),
              child: Container()),
        ));
  }

  Widget _renderRecentlyViewSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppPadding.p20),
          child: _renderTitleText(
            context,
            title: S.of(context).recentlyViewed,
            action: _renderShowListRecentlyViewedButton(context),
          ),
        ),
        _renderListRecentlyViewed(context),
      ],
    );
  }

  Widget _renderShowListRecentlyViewedButton(BuildContext context) {
    return IconButton.filled(
      color: AppColors.primary,
      style: ButtonStyle(
        padding: MaterialStateProperty.all(EdgeInsets.zero),
      ),
      onPressed: () {},
      iconSize: AppFontSize.f20,
      icon: const Icon(
        Icons.arrow_forward,
        color: AppColors.white,
      ),
    );
  }

  Widget _renderListRecentlyViewed(BuildContext context) {
    return SizedBox(
      height: AppSize.s90,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding:
            const EdgeInsets.only(left: AppPadding.p20, top: AppPadding.p10),
        itemCount: 10,
        itemBuilder: (context, index) => const Padding(
          padding: EdgeInsets.only(right: AppPadding.p15),
          child: XAvatar(),
        ),
      ),
    );
  }

  Widget _renderListFavoritedProducts(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: AppPadding.p20),
      child: Column(
        children: [
          _renderProduct(context),
        ],
      ),
    );
  }

  Widget _renderProduct(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: AppPadding.p8),
      child: XProductCartEdit(),
    );
  }

  Widget _renderEmptyFavoritedProduct(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: AppPadding.p59),
      child: Container(
          decoration: BoxDecoration(
            color: AppColors.white,
            boxShadow: AppDecorations.shadowTwo,
            borderRadius: BorderRadius.circular(AppRadius.r100),
          ),
          child: XCircleEmptyContainer(
            emptyIcon: Assets.svg.favoritesEmpty.svg(width: AppSize.s70),
          )),
    );
  }
}
