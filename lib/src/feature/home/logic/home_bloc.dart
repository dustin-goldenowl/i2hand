import 'dart:async';

import 'package:get_it/get_it.dart';
import 'package:i2hand/src/feature/home/logic/home_state.dart';
import 'package:i2hand/src/local/database_app.dart';
import 'package:i2hand/src/local/entities/most_viewed_products_entity.dart';
import 'package:i2hand/src/local/entities/new_products_entity.dart';
import 'package:i2hand/src/local/entities/product_entity.dart';
import 'package:i2hand/src/local/repo/most_viewed_product/most_viewed_product_local_repo.dart';
import 'package:i2hand/src/local/repo/new_product/new_product_local_repo.dart';
import 'package:i2hand/src/local/repo/product/product_local_repo.dart';
import 'package:i2hand/src/network/model/product/product.dart';
import 'package:i2hand/src/network/model/user_product/user_product.dart';
import 'package:i2hand/src/utils/base_cubit.dart';

class HomeBloc extends BaseCubit<HomeState> {
  HomeBloc() : super(HomeState(listCategory: List.empty(growable: true)));

  StreamSubscription? _newestProductsStream;
  StreamSubscription? _mostViewedProductsStream;

  Future<void> initial() async {
    _initStream();
  }

  @override
  Future<void> close() {
    _newestProductsStream?.cancel();
    _mostViewedProductsStream?.cancel();
    return super.close();
  }

  void _initStream() {
    _newestProductsStream = GetIt.I
        .get<NewProductsLocalRepo>()
        .getAllDetails()
        .watch()
        .listen((listNewProducts) async {
      final listProduct = await _getListNewProduct(listNewProducts);
      emit(state.copyWith(
        listNewProducts: listProduct,
      ));
    });

    _mostViewedProductsStream = GetIt.I
        .get<MostViewedProductsLocalRepo>()
        .getAllDetails()
        .watch()
        .listen((listMostViewedProducts) async {
      final listProduct =
          await _getListMostViewedProducts(listMostViewedProducts);
      emit(state.copyWith(
        listMostViewedProduct: listProduct,
      ));
    });
  }

  Future<List<MProduct>> _getListMostViewedProducts(
      List<MostViewProductsEntityData> listMostViewedProducts) async {
    List<MProduct> listProduct = [];
    final listProductsId = listMostViewedProducts.convertToProductData();
    for (MUserProduct productId in listProductsId) {
      final product = await GetIt.I
          .get<ProductsLocalRepo>()
          .getDetail(id: productId.id)
          .get();
      listProduct.addAll(product.convertToProductData());
    }
    return listProduct;
  }

  Future<List<MProduct>> _getListNewProduct(
      List<NewProductsEntityData> listNewProducts) async {
    List<MProduct> listProduct = [];
    final listProductsId = listNewProducts.convertToProductData();
    for (MUserProduct productId in listProductsId) {
      final product = await GetIt.I
          .get<ProductsLocalRepo>()
          .getDetail(id: productId.id)
          .get();
      listProduct.addAll(product.convertToProductData());
    }
    return listProduct;
  }
}
