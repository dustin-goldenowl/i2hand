import 'package:flutter/material.dart';
import 'package:i2hand/gen/assets.gen.dart';
import 'package:i2hand/src/localization/localization_utils.dart';
import 'package:i2hand/src/router/coordinator.dart';
import 'package:i2hand/src/theme/colors.dart';
import 'package:i2hand/src/theme/styles.dart';
import 'package:i2hand/src/theme/value.dart';
import 'package:i2hand/src/utils/padding_utils.dart';
import 'package:i2hand/src/utils/string_utils.dart';
import 'package:i2hand/widget/avatar/avatar.dart';
import 'package:i2hand/widget/button/fill_button.dart';
import 'package:i2hand/widget/button/icon_button.dart';
import 'package:i2hand/widget/card/product_card_order.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late PageController _pageController;
  // Store the current page number
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page?.round() ?? 0;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
          child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _renderHeaderBar(context),
          _renderHelloText(context),
          _renderRecentlyViewed(context),
          _renderMyOrdersSection(context),
        ],
      )),
    );
  }

  Widget _renderHeaderBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSize.s20),
      child: Row(
        children: [
          _renderAvatar(),
          XPaddingUtils.horizontalPadding(width: AppPadding.p16),
          _renderMyActivity(context),
          _renderActionsButton(context),
        ],
      ),
    );
  }

  Widget _renderAvatar() {
    return const XAvatar(
      imageSize: AppSize.s40,
    );
  }

  Widget _renderMyActivity(BuildContext context) {
    return XFillButton(
      padding: const EdgeInsets.symmetric(
        horizontal: AppPadding.p16,
        vertical: AppPadding.p0,
      ),
      onPressed: () {},
      label: Text(
        S.of(context).myActivity,
        style: AppTextStyle.hintTextStyle.copyWith(
          color: AppColors.white,
          fontSize: AppFontSize.f16,
        ),
      ),
      borderRadius: AppRadius.r40,
    );
  }

  Widget _renderActionsButton(BuildContext context) {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.max,
        children: [
          XIconButton(
            bgColor: AppColors.backgroundButton,
            icon: Icons.history,
            onPressed: () {
              //TODO: show list history product
            },
            iconColor: AppColors.primary,
          ),
          _renderSettingButton(),
        ],
      ),
    );
  }

  Widget _renderSettingButton() {
    return XIconButton(
      bgColor: AppColors.backgroundButton,
      icon: Icons.settings,
      onPressed: () {
        AppCoordinator.showSettingScreen();
      },
      iconColor: AppColors.primary,
    );
  }

  Widget _renderHelloText(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: AppPadding.p20),
      child: Row(
        children: [
          Text(
            S.of(context).hello,
            style: AppTextStyle.titleTextStyle.copyWith(
              fontSize: AppFontSize.f28,
            ),
          ),
        ],
      ),
    );
  }

  Widget _renderRecentlyViewed(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppPadding.p20,
        vertical: AppPadding.p15,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _renderTitle(title: S.of(context).recentlyViewed, isShowMore: true),
          XPaddingUtils.verticalPadding(height: AppPadding.p12),
          _renderListRecentlyViewed(context),
        ],
      ),
    );
  }

  Widget _renderTitle({required String title, bool isShowMore = false}) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: AppTextStyle.titleTextStyle.copyWith(
            fontSize: AppFontSize.f21,
          ),
        ),
        isShowMore
            ? XIconButton(
                bgColor: AppColors.primary,
                icon: Icons.arrow_forward,
                iconColor: AppColors.white,
                iconSize: AppSize.s20,
                onPressed: () {},
              )
            : const SizedBox.shrink(),
      ],
    );
  }

  Widget _renderListRecentlyViewed(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const XAvatar(imageSize: AppSize.s50),
          XPaddingUtils.horizontalPadding(width: AppPadding.p10),
          const XAvatar(imageSize: AppSize.s50),
        ],
      ),
    );
  }

  Widget _renderMyOrdersSection(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppPadding.p20),
            child: _renderTitle(title: S.of(context).myOrders),
          ),
          XPaddingUtils.verticalPadding(height: AppPadding.p12),
          _renderListOptions(context),
          XPaddingUtils.verticalPadding(height: AppPadding.p12),
          _renderListOrders(context),
        ],
      ),
    );
  }

  Widget _renderListOptions(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          XPaddingUtils.horizontalPadding(width: AppPadding.p20),
          _renderOptionButtons(context,
              label: S.of(context).toPay, isSelected: _currentPage == 0),
          XPaddingUtils.horizontalPadding(width: AppPadding.p8),
          _renderOptionButtons(context,
              label: S.of(context).toReceive, isSelected: _currentPage == 1),
          XPaddingUtils.horizontalPadding(width: AppPadding.p8),
          _renderOptionButtons(context,
              label: S.of(context).toReview, isSelected: _currentPage == 2),
          XPaddingUtils.horizontalPadding(width: AppPadding.p20),
        ],
      ),
    );
  }

  Widget _renderOptionButtons(BuildContext context,
      {required String label, bool isSelected = false}) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        decoration: BoxDecoration(
          color:
              isSelected ? AppColors.secondPrimary : AppColors.backgroundButton,
          borderRadius: BorderRadius.circular(AppRadius.r40),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: AppPadding.p20,
          vertical: AppPadding.p6,
        ),
        clipBehavior: Clip.hardEdge,
        child: Text(
          label,
          style: isSelected
              ? AppTextStyle.contentTexStyleBold
                  .copyWith(color: AppColors.primary)
              : AppTextStyle.contentTexStyle.copyWith(color: AppColors.primary),
        ),
      ),
    );
  }

  Widget _renderListOrders(BuildContext context) {
    return Expanded(
      child: PageView.builder(
        controller: _pageController,
        itemBuilder: (context, index) {
          switch (index) {
            case 0:
              return _renderListToPay(context);
            case 1:
              return _renderListToReceive(context);
            case 2:
            default:
              return _renderListToReview(context);
          }
        },
        itemCount: 3,
      ),
    );
  }

  Widget _renderListToPay(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppPadding.p20),
      child: Column(
        children: [
          XProductCartOrder(
            image: Assets.svg.product.svg(
              width: AppSize.s90,
              height: AppSize.s90,
            ),
            orderNumber:
                StringUtils.createGenerateRandomOrderNumber(length: 10),
            delivery: S.of(context).standardDelivery,
            status: S.of(context).delivered,
          )
        ],
      ),
    );
  }

  Widget _renderListToReceive(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppPadding.p20),
      child: Column(
        children: [
          XProductCartOrder(
            image: Assets.svg.product.svg(
              width: AppSize.s90,
              height: AppSize.s90,
            ),
            orderNumber:
                StringUtils.createGenerateRandomOrderNumber(length: 10),
            delivery: S.of(context).standardDelivery,
            status: S.of(context).delivered,
          )
        ],
      ),
    );
  }

  Widget _renderListToReview(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppPadding.p20),
      child: Column(
        children: [
          XProductCartOrder(
            image: Assets.svg.product.svg(
              width: AppSize.s90,
              height: AppSize.s90,
            ),
            orderNumber:
                StringUtils.createGenerateRandomOrderNumber(length: 10),
            delivery: S.of(context).standardDelivery,
            status: S.of(context).delivered,
          )
        ],
      ),
    );
  }
}
