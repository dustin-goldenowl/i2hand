import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i2hand/gen/assets.gen.dart';
import 'package:i2hand/src/feature/cart/logic/cart_bloc.dart';
import 'package:i2hand/src/feature/cart/logic/cart_state.dart';
import 'package:i2hand/src/localization/localization_utils.dart';
import 'package:i2hand/src/network/model/product/product.dart';
import 'package:i2hand/src/router/coordinator.dart';
import 'package:i2hand/src/theme/colors.dart';
import 'package:i2hand/src/theme/decorations.dart';
import 'package:i2hand/src/theme/styles.dart';
import 'package:i2hand/src/theme/value.dart';
import 'package:i2hand/src/utils/padding_utils.dart';
import 'package:i2hand/src/utils/string_ext.dart';
import 'package:i2hand/src/utils/utils.dart';
import 'package:i2hand/widget/appbar/app_bar.dart';
import 'package:i2hand/widget/card/product_card_edit.dart';
import 'package:i2hand/widget/container/circle_empty_container.dart';
import 'package:i2hand/widget/section/shipping_address_section.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    super.initState();
    context.read<CartBloc>().inital();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
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
    return BlocBuilder<CartBloc, CartState>(
      buildWhen: (previous, current) =>
          previous.shippingAddress != current.shippingAddress,
      builder: (context, state) {
        return XShippingAddressSection(
          onChangeAddress: (value) =>
              context.read<CartBloc>().onChangeShippingAddress(value),
          address: state.shippingAddress,
        );
      },
    );
  }

  Widget _renderCartSection(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      buildWhen: (previous, current) =>
          !listEquals(previous.listProductsInCart, current.listProductsInCart),
      builder: (context, state) {
        return state.listProductsInCart.isEmpty
            ? _renderEmptyCartProduct()
            : _renderListProductInCart(state.listProductsInCart);
      },
    );
  }

  Widget _renderEmptyCartProduct() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppPadding.p59),
      child: Container(
          decoration: BoxDecoration(
            color: AppColors.white,
            boxShadow: AppDecorations.shadowTwo,
            borderRadius: BorderRadius.circular(AppRadius.r100),
          ),
          child: XCircleEmptyContainer(
            emptyIcon: Assets.svg.cartApp.svg(width: AppSize.s105),
          )),
    );
  }

  Widget _renderListProductInCart(List<MProduct> listProductsInCart) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
          horizontal: AppPadding.p20, vertical: AppPadding.p10),
      child: Column(
        children: [
          for (MProduct product in listProductsInCart)
            _renderProduct(context,
                product: product,
                onTapPay: () =>
                    AppCoordinator.showPaymentScreen(productId: product.id),
                onTapRemove: () =>
                    context.read<CartBloc>().removeCartProduct(id: product.id)),
        ],
      ),
    );
  }

  Widget _renderProduct(
    BuildContext context, {
    required MProduct product,
    Function? onTapAddToCart,
    Function? onTapPay,
    required Function onTapRemove,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppPadding.p8),
      child: XProductCartEdit(
        title: product.title,
        price: Utils.createPriceText(product.price),
        onTapRemove: onTapRemove,
        onTapAddToCart: onTapAddToCart,
        onTapPayProduct: onTapPay,
        image: (isNullOrEmpty(product.image))
            ? null
            : Image.memory(
                product.image!.convertToUint8List(),
                width: AppSize.s105,
                height: AppSize.s105,
                fit: BoxFit.cover,
              ),
      ),
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
    return BlocBuilder<CartBloc, CartState>(
      buildWhen: (previous, current) => !listEquals(
          previous.listProductsInWishlist, current.listProductsInWishlist),
      builder: (context, state) {
        return state.listProductsInWishlist.isEmpty
            ? _renderEmptyWishlistProduct()
            : _renderListProductInWishlist(state.listProductsInWishlist);
      },
    );
  }

  Widget _renderEmptyWishlistProduct() {
    return Container(
      child: Assets.jsons.emptyWishlist.lottie(),
    );
  }

  Widget _renderListProductInWishlist(List<MProduct> listProductsInWishlist) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: AppPadding.p10),
      child: Column(
        children: [
          for (MProduct product in listProductsInWishlist)
            _renderProduct(context,
                product: product,
                onTapAddToCart: () =>
                    context.read<CartBloc>().addFromWishlist(id: product.id),
                onTapRemove: () => context
                    .read<CartBloc>()
                    .removeWishlistProduct(id: product.id)),
        ],
      ),
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
}
