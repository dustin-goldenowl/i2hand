import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:i2hand/src/dialog/toast_wrapper.dart';
import 'package:i2hand/src/feature/cart/logic/cart_state.dart';
import 'package:i2hand/src/feature/home/feature/search/widget/location_picker.dart';
import 'package:i2hand/src/local/database_app.dart';
import 'package:i2hand/src/local/entities/cart_entity.dart';
import 'package:i2hand/src/local/entities/product_entity.dart';
import 'package:i2hand/src/local/entities/wishlist_products_entity.dart';
import 'package:i2hand/src/local/repo/cart/cart_local_repo.dart';
import 'package:i2hand/src/local/repo/product/product_local_repo.dart';
import 'package:i2hand/src/local/repo/wishlist_product/wishlist_product_local_repo.dart';
import 'package:i2hand/src/network/model/product/product.dart';
import 'package:i2hand/src/network/model/user_product/user_product.dart';
import 'package:i2hand/src/theme/colors.dart';
import 'package:i2hand/src/utils/base_cubit.dart';
import 'package:i2hand/src/utils/string_utils.dart';
import 'package:i2hand/src/utils/utils.dart';

class CartBloc extends BaseCubit<CartState> {
  CartBloc()
      : super(
          CartState(
            listProductsInCart: List.empty(growable: true),
            listProductsInWishlist: List.empty(growable: true),
            listPopularProduct: List.empty(growable: true),
          ),
        );

  StreamSubscription? _wishlistStream;
  StreamSubscription? _cartStream;

  void inital() {
    XToast.showLoading();
    _initStream();
  }

  @override
  Future<void> close() {
    _wishlistStream?.cancel();
    _cartStream?.cancel();
    return super.close();
  }

  void _initStream() {
    _streamListWishlistProduct();
    _streamListCartProduct();
  }

  void _streamListWishlistProduct() {
    _wishlistStream = GetIt.I
        .get<WishlistProductsLocalRepo>()
        .getAllDetails()
        .watch()
        .listen((listProductsEntity) async {
      final listProduct =
          await _getListProduct(wishlistProductEntity: listProductsEntity);
      emit(state.copyWith(listProductsInWishlist: listProduct));
    });
  }

  void _streamListCartProduct() {
    _cartStream = GetIt.I
        .get<CartLocalRepo>()
        .getAllDetails()
        .watch()
        .listen((listProductsEntity) async {
      final listProduct =
          await _getListProduct(cartProductEntity: listProductsEntity);
      emit(state.copyWith(listProductsInCart: listProduct));
      XToast.hideLoading();
    });
  }

  Future<List<MProduct>> _getListProduct(
      {List<WishlistProductsEntityData>? wishlistProductEntity,
      List<CartEntityData>? cartProductEntity}) async {
    List<MProduct> listProduct = [];
    final listProductsId = !isNullOrEmpty(wishlistProductEntity)
        ? wishlistProductEntity!.convertToUserProductData()
        : !isNullOrEmpty(cartProductEntity)
            ? cartProductEntity!.convertToUserProductData()
            : [];
    for (MUserProduct productId in listProductsId) {
      final product = await GetIt.I
          .get<ProductsLocalRepo>()
          .getDetail(id: productId.id)
          .get();
      listProduct.addAll(product.convertToProductData());
    }
    return listProduct;
  }

  Future<void> selectLocationBottomsheet(BuildContext context,
      {required String location}) async {
    final isLocation = StringUtils.isNullOrEmpty(location);
    await showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) => FractionallySizedBox(
        heightFactor: 0.65,
        child: Scaffold(
          backgroundColor: Colors.white,
          body: LayoutBuilder(
            builder: (context, constraints) => XLocationPicker(
              bottomsheetHeight: constraints.maxHeight,
              initCountry: isLocation ? '' : location.split(', ')[1],
              initState: isLocation ? '' : location.split(', ')[0],
            ),
          ),
        ),
      ),
      isScrollControlled: true,
      barrierColor: AppColors.black.withOpacity(0.6),
      enableDrag: true,
      isDismissible: false,
    ).then((value) {
      if (value != null) {}
    });
  }

  void onChangeShippingAddress(String address) {
    emit(state.copyWith(shippingAddress: address));
  }

  String getAddressText() {
    final addressRawText =
        state.shippingAddress.replaceAll(RegExp(r'\[|\]'), '');
    final addressListData = addressRawText.split(',');
    final removeEmptyAddressDataText =
        addressListData.where((element) => element.trim().isNotEmpty).toList();
    return removeEmptyAddressDataText.join(',');
  }

  void removeWishlistProduct({required String id}) async {
    await GetIt.I.get<WishlistProductsLocalRepo>().deleteProductById(id);
  }

  void removeCartProduct({required String id}) async {
    await GetIt.I.get<CartLocalRepo>().deleteProductById(id);
  }

  void addFromWishlist({required String id}) async {
    XToast.showLoading();
    await GetIt.I.get<CartLocalRepo>().insertDetail(CartEntityData(id: id));
  }
}
