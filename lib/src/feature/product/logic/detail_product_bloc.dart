import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:i2hand/src/feature/product/logic/detail_product_state.dart';
import 'package:i2hand/src/local/database_app.dart';
import 'package:i2hand/src/local/repo/cart/cart_local_repo.dart';
import 'package:i2hand/src/local/repo/wishlist_product/wishlist_product_local_repo.dart';
import 'package:i2hand/src/network/data/product/product_repository.dart';
import 'package:i2hand/src/network/data/user/user_repository.dart';
import 'package:i2hand/src/network/model/product/product.dart';
import 'package:i2hand/src/network/model/user/user.dart';
import 'package:i2hand/src/utils/base_cubit.dart';
import 'package:i2hand/src/utils/utils.dart';

class DetailProductBloc extends BaseCubit<DetailProductState> {
  DetailProductBloc(String id)
      : super(DetailProductState(
          id: id,
          product: MProduct.empty(),
        ));

  void _fetchStatusFail() =>
      emit(state.copyWith(status: DetailProductScreenStatus.fail));

  void _fetchStatusSuccess() =>
      emit(state.copyWith(status: DetailProductScreenStatus.success));

  Future<void> initial(BuildContext context) async {
    await _fetchProductData(state.id);
    await _fetchProductImage(state.id);
    await _initSavedProduct(state.id);
  }

  Future<void> _fetchProductData(String id) async {
    emit(state.copyWith(status: DetailProductScreenStatus.loading));
    try {
      final result = await GetIt.I
          .get<ProductRepository>()
          .getOrAddProduct(MProduct(id: id));
      if (result.data == null) return _fetchStatusFail();
      emit(state.copyWith(product: result.data));
      await _fetchOwnerData(ownerId: result.data!.owner);
    } catch (e) {
      _fetchStatusFail();
      xLog.e(e);
    }
  }

  Future<void> _fetchOwnerData({required String ownerId}) async {
    try {
      final result =
          await GetIt.I.get<UserRepository>().getOrAddUser(MUser(id: ownerId));
      if (result.data == null) return _fetchStatusFail();
      await _fetchOwnerAvatar(user: result.data!);
    } catch (e) {
      xLog.e(e);
      rethrow;
    }
  }

  Future<void> _initSavedProduct(String id) async {
    final result =
        await GetIt.I.get<WishlistProductsLocalRepo>().isContainInDatabase(id);
    emit(state.copyWith(isSaved: result));
  }

  Future<void> _fetchOwnerAvatar({required MUser user}) async {
    try {
      final result = await GetIt.I.get<UserRepository>().getImage(user.id);
      if (result.data == null) emit(state.copyWith(user: user));
      final userData =
          user.copyWith(avatar: result.data!.map((e) => e.toString()).toList());
      emit(state.copyWith(user: userData));
      _fetchStatusSuccess();
    } catch (e) {
      xLog.e(e);
      rethrow;
    }
  }

  Future<void> _fetchProductImage(String id) async {
    emit(state.copyWith(assetsStatus: FetchAssetsStatus.loading));
    try {
      final images = await GetIt.I.get<ProductRepository>().getImage(id);
      if (isNullOrEmpty(images.data)) {
        emit(state.copyWith(assetsStatus: FetchAssetsStatus.fail));
        return;
      }
      emit(state.copyWith(
          listImage: images.data, assetsStatus: FetchAssetsStatus.success));
    } catch (e) {
      xLog.e(e);
      emit(state.copyWith(assetsStatus: FetchAssetsStatus.fail));
    }
  }

  void onChangedCarouselIndex(int index) {
    emit(state.copyWith(carouselIndex: index));
  }

  Future<void> saveToWishlist() async {
    try {
      if (!state.isSaved) {
        // Save to wishlist
        await GetIt.I
            .get<WishlistProductsLocalRepo>()
            .insertDetail(WishlistProductsEntityData(id: state.id));
        emit(state.copyWith(isSaved: true));
      } else {
        // Remove from wishlist
        await GetIt.I
            .get<WishlistProductsLocalRepo>()
            .deleteProductById(state.id);
        emit(state.copyWith(isSaved: false));
      }
    } catch (e) {
      xLog.e(e);
    }
  }

  Future<void> addProductToCart() async {
    await GetIt.I
        .get<CartLocalRepo>()
        .insertDetail(CartEntityData(id: state.id));
  }
}
