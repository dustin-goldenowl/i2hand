import 'dart:math';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i2hand/gen/assets.gen.dart';
import 'package:i2hand/package/dismiss_keyboard/dismiss_keyboard.dart';
import 'package:i2hand/src/config/constants/app_const.dart';
import 'package:i2hand/src/feature/global/logic/global_bloc.dart';
import 'package:i2hand/src/feature/global/logic/global_state.dart';
import 'package:i2hand/src/feature/home/logic/home_bloc.dart';
import 'package:i2hand/src/feature/home/logic/home_state.dart';
import 'package:i2hand/src/localization/localization_utils.dart';
import 'package:i2hand/src/network/model/category/category.dart';
import 'package:i2hand/src/network/model/product/product.dart';
import 'package:i2hand/src/router/coordinator.dart';
import 'package:i2hand/src/theme/colors.dart';
import 'package:i2hand/src/theme/styles.dart';
import 'package:i2hand/src/theme/value.dart';
import 'package:i2hand/src/utils/padding_utils.dart';
import 'package:i2hand/src/utils/utils.dart';
import 'package:i2hand/widget/appbar/app_bar.dart';
import 'package:i2hand/widget/card/product_card.dart';
import 'package:i2hand/widget/carousel/default_carousel.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    context.read<HomeBloc>().initial();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.grey7,
      body: DismissKeyBoard(
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                _renderAppBar(),
                XPaddingUtils.verticalPadding(height: AppPadding.p10),
                _renderNotificationBanner(context),
                _renderCategoriesSection(context),
                XPaddingUtils.verticalPadding(height: AppPadding.p10),
                _renderNewProductSection(context),
                XPaddingUtils.verticalPadding(height: AppPadding.p10),
                _renderMostViewedProductSection(context),
                XPaddingUtils.verticalPadding(height: AppPadding.p45),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _renderAppBar() {
    return Container(
      color: AppColors.white,
      child: XAppBar(
          titlePage: S.of(context).i2hand,
          actions: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                  child: GestureDetector(
                onTap: () => AppCoordinator.showSearchScreen(options: ' '),
                child: Container(
                  decoration: BoxDecoration(
                      color: AppColors.grey8,
                      borderRadius: BorderRadius.circular(AppRadius.r30)),
                  padding: const EdgeInsets.all(AppPadding.p10),
                  child: Text(
                    S.of(context).search,
                    style: AppTextStyle.hintTextStyle,
                  ),
                ),
              ))
            ],
          )),
    );
  }

  Widget _renderNotificationBanner(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: AppPadding.p10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppRadius.r16),
        color: AppColors.white,
      ),
      child: XCarousel(
        jumpPage: 0,
        items: AppConstantData.listNotificationBanner,
      ),
    );
  }

  Widget _renderCategoriesSection(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: AppPadding.p10),
      padding: const EdgeInsets.symmetric(vertical: AppPadding.p10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppRadius.r16),
        color: AppColors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          _renderTitleSection(context, title: S.of(context).categories),
          XPaddingUtils.verticalPadding(height: AppPadding.p10),
          _renderListCategories(),
        ],
      ),
    );
  }

  Widget _renderTitleSection(BuildContext context, {required String title}) {
    return Padding(
      padding: const EdgeInsets.only(left: AppPadding.p16),
      child: Text(
        title,
        style:
            AppTextStyle.contentTexStyleBold.copyWith(color: AppColors.black),
      ),
    );
  }

  Widget _renderListCategories() {
    return BlocBuilder<GlobalBloc, GlobalState>(
      buildWhen: (previous, current) =>
          !listEquals(previous.listCategories, current.listCategories),
      builder: (context, state) {
        return SizedBox(
          height: AppSize.s200,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: context.read<GlobalBloc>().getNumberColumns(),
              itemBuilder: (context, index) {
                return _renderCategoryInOneColumn(
                    firstCategory: state.listCategories[2 * index],
                    secondCategory:
                        context.read<GlobalBloc>().checkInvalidIndex(index)
                            ? null
                            : state.listCategories[2 * index + 1]);
              }),
        );
      },
    );
  }

  Widget _renderCategoryInOneColumn(
      {required MCategory firstCategory, MCategory? secondCategory}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(child: _renderCategory(firstCategory)),
        XPaddingUtils.verticalPadding(height: AppPadding.p12),
        isNullOrEmpty(secondCategory)
            ? const SizedBox.shrink()
            : _renderCategory(secondCategory!),
      ],
    );
  }

  Widget _renderCategory(MCategory category) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: AppPadding.p12),
      width: AppSize.s70,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.memory(
            Uint8List.fromList(
              category.image?.map((e) => int.parse(e)).toList() ?? [],
            ),
            height: AppSize.s60,
            width: AppSize.s60,
          ),
          Text(
            category.name,
            style:
                AppTextStyle.contentTexStyle.copyWith(color: AppColors.black),
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            maxLines: 2,
          )
        ],
      ),
    );
  }

  Widget _renderNewProductSection(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: AppPadding.p10),
      padding: const EdgeInsets.symmetric(vertical: AppPadding.p10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppRadius.r16),
        color: AppColors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          _renderTitleSection(context, title: S.of(context).newProduct),
          XPaddingUtils.verticalPadding(height: AppPadding.p10),
          _renderListNewItems(context),
        ],
      ),
    );
  }

  Widget _renderListNewItems(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      buildWhen: (previous, current) =>
          !listEquals(previous.listNewProducts, current.listNewProducts),
      builder: (context, state) {
        return SizedBox(
          height: AppSize.s250,
          child: (isNullOrEmpty(state.listNewProducts))
              ? const SizedBox.shrink()
              : ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: state.listNewProducts!.length > 5
                      ? 6
                      : state.listNewProducts!.length,
                  itemBuilder: (context, index) {
                    if (index == 5) {
                      return _renderMoreProduct(
                          context, state.listNewProducts![5]);
                    }
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: AppPadding.p12, vertical: AppPadding.p6),
                      child: XProductCard(
                        product: state.listNewProducts![index],
                      ),
                    );
                  }),
        );
      },
    );
  }

  Widget _renderMoreProduct(BuildContext context, MProduct product) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: AppPadding.p12, vertical: AppPadding.p6),
      child: Stack(
        children: [
          Container(
            width: AppSize.s150,
            height: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppRadius.r8),
            ),
            clipBehavior: Clip.hardEdge,
            child: XProductCard(
              product: product,
            ),
          ),
          Positioned.fill(
            child: GestureDetector(
              onTap: () => AppCoordinator.showSearchScreen(options: ' '),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: AppColors.showMoreGradient,
                  ),
                  borderRadius: BorderRadius.circular(AppRadius.r8),
                ),
                child: Transform.rotate(
                    angle: -pi / 2, child: Assets.jsons.showMore.lottie()),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _renderMostViewedProductSection(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: AppPadding.p10),
      padding: const EdgeInsets.symmetric(vertical: AppPadding.p10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppRadius.r16),
        color: AppColors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          _renderTitleSection(context, title: S.of(context).mostViewesProduct),
          XPaddingUtils.verticalPadding(height: AppPadding.p10),
          _renderListMostViewedItems(context),
        ],
      ),
    );
  }

  Widget _renderListMostViewedItems(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      buildWhen: (previous, current) => !listEquals(
          previous.listMostViewedProduct, current.listMostViewedProduct),
      builder: (context, state) {
        return SizedBox(
            height: AppSize.s250,
            child: (isNullOrEmpty(state.listMostViewedProduct))
                ? const SizedBox.shrink()
                : ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: state.listMostViewedProduct!.length,
                    itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: AppPadding.p12,
                            vertical: AppPadding.p6),
                        child: XProductCard(
                          product: state.listMostViewedProduct![index],
                        )),
                  ));
      },
    );
  }
}
