import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:i2hand/src/local/entities/most_viewed_products_entity.dart';
import 'package:i2hand/src/local/entities/new_products_entity.dart';
import 'package:i2hand/src/local/entities/product_entity.dart';
import 'package:i2hand/src/local/repo/most_viewed_product/most_viewed_product_local_repo.dart';
import 'package:i2hand/src/local/repo/new_product/new_product_local_repo.dart';
import 'package:i2hand/src/local/repo/product/product_local_repo.dart';
import 'package:i2hand/src/localization/localization_utils.dart';
import 'package:i2hand/src/network/model/product/product.dart';
import 'package:i2hand/src/network/model/user_product/user_product.dart';

enum ProductStatusEnum {
  none,
  newest,
  mostViewed;

  String getText(context) {
    switch (this) {
      case ProductStatusEnum.mostViewed:
        return S.of(context).mostViewed;
      case ProductStatusEnum.newest:
        return S.of(context).newest;
      case ProductStatusEnum.none:
        return '';
    }
  }

  Future<List<MProduct>> getListProducts(BuildContext context) async {
    switch (this) {
      case ProductStatusEnum.none:
        final listData =
            await GetIt.I.get<ProductsLocalRepo>().getAllDetails().get();
        return listData.convertToProductData();
      case ProductStatusEnum.newest:
        final listProductId =
            await GetIt.I.get<NewProductsLocalRepo>().getAllDetails().get();
        List<MProduct> listProduct = [];
        for (MUserProduct productId in listProductId.convertToProductData()) {
          final product = await GetIt.I
              .get<ProductsLocalRepo>()
              .getDetail(id: productId.id)
              .get();
          listProduct.add(product.convertToProductData().first);
        }
        return listProduct;
      case ProductStatusEnum.mostViewed:
        final listProductId =
            await GetIt.I.get<MostViewedProductsLocalRepo>().getAllDetails().get();
        List<MProduct> listProduct = [];
        for (MUserProduct productId in listProductId.convertToProductData()) {
          final product = await GetIt.I
              .get<ProductsLocalRepo>()
              .getDetail(id: productId.id)
              .get();
          listProduct.add(product.convertToProductData().first);
        }
        return listProduct;
    }
  }
}

enum PriceFilterEnum {
  none,
  priceHighToLow,
  priceLowToHigh;

  String getText(context) {
    switch (this) {
      case PriceFilterEnum.priceHighToLow:
        return S.of(context).priceHighToLow;
      case PriceFilterEnum.priceLowToHigh:
        return S.of(context).priceLowToHigh;
      case PriceFilterEnum.none:
        return '';
    }
  }
}
