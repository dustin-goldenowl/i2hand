import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i2hand/gen/assets.gen.dart';
import 'package:i2hand/src/config/enum/order_enum.dart';
import 'package:i2hand/src/feature/profile/logic/profile_bloc.dart';
import 'package:i2hand/src/feature/profile/logic/profile_state.dart';
import 'package:i2hand/src/localization/localization_utils.dart';
import 'package:i2hand/src/network/model/order/order.dart';
import 'package:i2hand/src/network/model/recently_viewed/recently_viewed.dart';
import 'package:i2hand/src/network/model/user/user.dart';
import 'package:i2hand/src/router/coordinator.dart';
import 'package:i2hand/src/theme/colors.dart';
import 'package:i2hand/src/theme/styles.dart';
import 'package:i2hand/src/theme/value.dart';
import 'package:i2hand/src/utils/padding_utils.dart';
import 'package:i2hand/src/utils/string_ext.dart';
import 'package:i2hand/src/utils/string_utils.dart';
import 'package:i2hand/src/utils/utils.dart';
import 'package:i2hand/widget/avatar/avatar.dart';
import 'package:i2hand/widget/button/fill_button.dart';
import 'package:i2hand/widget/button/icon_button.dart';
import 'package:i2hand/widget/card/product_card_order.dart';
import 'package:i2hand/widget/section/recently_viewed_section.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ProfileBloc>().inital();
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
    return BlocSelector<ProfileBloc, ProfileState, MUser>(
      selector: (state) {
        return state.account;
      },
      builder: (context, account) {
        return XAvatar(
          imageSize: AppSize.s40,
          memoryData: isNullOrEmpty(account.avatar)
              ? null
              : account.avatar!.convertToUint8List(),
          imageType:
              isNullOrEmpty(account.avatar) ? ImageType.none : ImageType.memory,
        );
      },
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
    return BlocBuilder<ProfileBloc, ProfileState>(
      buildWhen: (previous, current) => previous.account != current.account,
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.only(left: AppPadding.p20),
          child: DefaultTextStyle(
            style: AppTextStyle.titleTextStyle.copyWith(
              fontSize: AppFontSize.f28,
            ),
            child: Row(
              children: [
                Text(S.of(context).hello),
                (StringUtils.isNullOrEmpty(state.account.name))
                    ? const SizedBox.shrink()
                    : Text(state.account.name!),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _renderRecentlyViewed(BuildContext context) {
    return BlocSelector<ProfileBloc, ProfileState,
        List<MRecentlyViewedProduct>>(
      selector: (state) {
        return state.listRecentlyViewed;
      },
      builder: (context, listRecently) {
        return XRecentlyViewedProductSection(listRecentlyVieweds: listRecently);
      },
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
    return BlocBuilder<ProfileBloc, ProfileState>(
      buildWhen: (previous, current) =>
          previous.numberPage != current.numberPage,
      builder: (context, state) {
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              XPaddingUtils.horizontalPadding(width: AppPadding.p20),
              _renderOptionButtons(
                context,
                label: S.of(context).toShip,
                isSelected: state.numberPage == 0,
                onTap: () => context.read<ProfileBloc>().jumpToPage(0),
              ),
              XPaddingUtils.horizontalPadding(width: AppPadding.p8),
              _renderOptionButtons(
                context,
                label: S.of(context).toReceive,
                isSelected: state.numberPage == 1,
                onTap: () => context.read<ProfileBloc>().jumpToPage(1),
              ),
              XPaddingUtils.horizontalPadding(width: AppPadding.p8),
              _renderOptionButtons(
                context,
                label: S.of(context).toReview,
                isSelected: state.numberPage == 2,
                onTap: () => context.read<ProfileBloc>().jumpToPage(2),
              ),
              XPaddingUtils.horizontalPadding(width: AppPadding.p20),
            ],
          ),
        );
      },
    );
  }

  Widget _renderOptionButtons(BuildContext context,
      {required String label,
      bool isSelected = false,
      required Function() onTap}) {
    return GestureDetector(
      onTap: onTap,
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
      child: BlocBuilder<ProfileBloc, ProfileState>(
        buildWhen: (previous, current) =>
            !listEquals(previous.listOrder, current.listOrder),
        builder: (context, state) {
          final listToPay = state.listOrder
              .where((element) => element.status == OrderStatusEnum.succeeded)
              .toList();
          return PageView.builder(
            controller: context.read<ProfileBloc>().pageController,
            itemBuilder: (context, index) {
              switch (index) {
                case 0:
                  return _renderListToPay(context, listOrder: listToPay);
                case 1:
                  return _renderListToReceive(context);
                case 2:
                default:
                  return _renderListToReview(context);
              }
            },
            itemCount: 3,
            onPageChanged: (value) =>
                context.read<ProfileBloc>().jumpToPage(value),
          );
        },
      ),
    );
  }

  Widget _renderListToPay(BuildContext context,
      {required List<MOrder> listOrder}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppPadding.p20),
      child: Column(
        children: _getListOrder(listOrder),
      ),
    );
  }

  List<Widget> _getListOrder(List<MOrder> listOrder) {
    List<Widget> listWidget = [];
    for (MOrder order in listOrder) {
      Widget image = isNullOrEmpty(order.image)
          ? Assets.svg.product.svg(
              width: AppSize.s90,
              height: AppSize.s90,
            )
          : Image.memory(
              order.image!.convertToUint8List(),
              width: AppSize.s90,
              height: AppSize.s90,
            );
      final orderWidget = XProductCartOrder(
        image: image,
        orderNumber: order.id,
        delivery: S.of(context).standardDelivery,
        status: S.of(context).delivered,
      );
      listWidget.add(orderWidget);
    }
    return listWidget;
  }

  Widget _renderListToReceive(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: AppPadding.p20),
      child: SizedBox.shrink(),
    );
  }

  Widget _renderListToReview(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: AppPadding.p20),
      child: SizedBox.shrink(),
    );
  }
}
