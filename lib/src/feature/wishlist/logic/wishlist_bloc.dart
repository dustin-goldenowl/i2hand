import 'dart:async';

import 'package:get_it/get_it.dart';
import 'package:i2hand/src/feature/wishlist/logic/wishlist_state.dart';
import 'package:i2hand/src/local/database_app.dart';
import 'package:i2hand/src/local/entities/product_entity.dart';
import 'package:i2hand/src/local/entities/wishlist_products_entity.dart';
import 'package:i2hand/src/local/repo/product/product_local_repo.dart';
import 'package:i2hand/src/local/repo/wishlist_product/wishlist_product_local_repo.dart';
import 'package:i2hand/src/network/model/product/product.dart';
import 'package:i2hand/src/network/model/user_product/user_product.dart';
import 'package:i2hand/src/utils/base_cubit.dart';

class WishlistBloc extends BaseCubit<WishlistState> {
  WishlistBloc() : super(WishlistState(wishlistProducts: List.empty()));

  StreamSubscription? _wishlistStream;

  void inital() {
    _initStream();
  }

  @override
  Future<void> close() {
    _wishlistStream?.cancel();
    return super.close();
  }

  void _initStream() {
    _streamListWishlistProduct();
  }

  void _streamListWishlistProduct() {
    _wishlistStream = GetIt.I
        .get<WishlistProductsLocalRepo>()
        .getAllDetails()
        .watch()
        .listen((listProductsEntity) async {
      final listProduct = await _getListProduct(listProductsEntity);
      emit(state.copyWith(wishlistProducts: listProduct));
    });
  }

  Future<List<MProduct>> _getListProduct(
      List<WishlistProductsEntityData> listProductsEntity) async {
    List<MProduct> listProduct = [];
    final listProductsId = listProductsEntity.convertToUserProductData();
    for (MUserProduct productId in listProductsId) {
      final product = await GetIt.I
          .get<ProductsLocalRepo>()
          .getDetail(id: productId.id)
          .get();
      listProduct.addAll(product.convertToProductData());
    }
    return listProduct;
  }

  void removeProduct({required String id}) async {
    await GetIt.I.get<WishlistProductsLocalRepo>().deleteProductById(id);
  }
}
