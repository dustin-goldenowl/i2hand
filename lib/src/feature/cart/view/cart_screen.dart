import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i2hand/gen/assets.gen.dart';
import 'package:i2hand/src/feature/cart/logic/cart_bloc.dart';
import 'package:i2hand/src/feature/cart/logic/cart_state.dart';
import 'package:i2hand/src/localization/localization_utils.dart';
import 'package:i2hand/src/router/coordinator.dart';
import 'package:i2hand/src/theme/colors.dart';
import 'package:i2hand/src/theme/decorations.dart';
import 'package:i2hand/src/theme/styles.dart';
import 'package:i2hand/src/theme/value.dart';
import 'package:i2hand/src/utils/padding_utils.dart';
import 'package:i2hand/src/utils/string_utils.dart';
import 'package:i2hand/widget/appbar/app_bar.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
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
              _renderShippingAddressSection(context),
              _renderCartSection(context),
              _renderFromYourWishlistSection(context),
              _renderMostViewedProductSection(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _renderAppBar(BuildContext context) {
    return XAppBar(
      titlePage: S.of(context).cart,
      actions: Row(
        children: [
          _renderNumberProducts(context),
        ],
      ),
    );
  }

  Widget _renderNumberProducts(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      buildWhen: (previous, current) =>
          previous.listProductsInCart != current.listProductsInCart,
      builder: (context, state) {
        return CircleAvatar(
          radius: AppRadius.r20,
          backgroundColor: AppColors.backgroundButton,
          child: Text(
            state.listProductsInCart.length.toString(),
            style:
                AppTextStyle.titleTextStyle.copyWith(fontSize: AppFontSize.f18),
          ),
        );
      },
    );
  }

  Widget _renderShippingAddressSection(BuildContext context) {
    return Container(
      width: double.infinity,
      alignment: Alignment.centerLeft,
      margin: const EdgeInsets.symmetric(
        horizontal: AppMargin.m20,
      ),
      padding: const EdgeInsets.only(
        left: AppPadding.p16,
        right: AppPadding.p12,
        top: AppPadding.p8,
        bottom: AppPadding.p8,
      ),
      decoration: BoxDecoration(
        color: AppColors.grey8,
        boxShadow: AppDecorations.fullShadow,
        borderRadius: BorderRadius.circular(AppRadius.r16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            S.of(context).shippingAddress,
            style:
                AppTextStyle.titleTextStyle.copyWith(fontSize: AppFontSize.f14),
          ),
          _renderAddress(context),
        ],
      ),
    );
  }

  Widget _renderAddress(BuildContext context) {
    return Row(
      children: [
        _renderShippingAddressText(context),
        XPaddingUtils.horizontalPadding(width: AppPadding.p40),
        _renderAddLocationButton(context),
      ],
    );
  }

  Widget _renderCartSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: AppPadding.p59),
      child: Container(
          decoration: BoxDecoration(
            color: AppColors.white,
            boxShadow: AppDecorations.shadowTwo,
            borderRadius: BorderRadius.circular(AppRadius.r100),
          ),
          child: CircleAvatar(
            backgroundColor: AppColors.white,
            radius: AppSize.s67,
            child: Assets.svg.cartApp.svg(width: AppSize.s105),
          )),
    );
  }

  Widget _renderFromYourWishlistSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppPadding.p20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _renderTitleText(context, title: S.of(context).fromYourWishlist),
          _renderWishlistSection(context),
        ],
      ),
    );
  }

  Widget _renderTitleText(BuildContext context, {required String title}) {
    return Text(
      title,
      style: AppTextStyle.titleTextStyle.copyWith(fontSize: AppFontSize.f21),
    );
  }

  Widget _renderWishlistSection(BuildContext context) {
    return Container(
      child: Assets.jsons.emptyWishlist.lottie(),
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

  Widget _renderAddLocationButton(BuildContext context) {
    return IconButton.filled(
      color: AppColors.primary,
      style: ButtonStyle(
        padding: MaterialStateProperty.all(EdgeInsets.zero),
      ),
      onPressed: () async => await AppCoordinator.showSelectLocationPage(
              address: context.read<CartBloc>().state.shippingAddress)
          .then((value) {
        if (value == null) return;
        context.read<CartBloc>().onChangeShippingAddress(value);
      }),
      iconSize: AppFontSize.f15,
      icon: const Icon(
        Icons.edit,
        color: AppColors.white,
      ),
    );
  }

  Widget _renderShippingAddressText(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      buildWhen: (previous, current) =>
          previous.shippingAddress != current.shippingAddress,
      builder: (context, state) {
        return Expanded(
          child: Text(
            StringUtils.isNullOrEmpty(state.shippingAddress.trim())
                ? S.of(context).pleaseAddYourAddress
                : context.read<CartBloc>().getAddressText(),
            style: AppTextStyle.contentTexStyle.copyWith(
              fontSize: AppFontSize.f10,
              color: AppColors.black,
            ),
          ),
        );
      },
    );
  }
}
