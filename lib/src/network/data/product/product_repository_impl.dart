import 'package:drift/drift.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:i2hand/src/local/database_app.dart';
import 'package:i2hand/src/local/repo/new_product/new_product_local_repo.dart';
import 'package:i2hand/src/localization/localization_utils.dart';
import 'package:i2hand/src/network/data/product/product_reference.dart';
import 'package:i2hand/src/network/data/product/product_reference_storage.dart';
import 'package:i2hand/src/network/data/product/product_repository.dart';
import 'package:i2hand/src/network/model/common/result.dart';
import 'package:i2hand/src/network/model/product/product.dart';
import 'package:i2hand/src/utils/utils.dart';

class ProductRepositoryImpl extends ProductRepository {
  final productRef = ProductReference();
  final productRefStorage = ProductStorageReference();

  @override
  Future<MResult<MProduct>> getOrAddProduct(MProduct category) {
    return productRef.getOrAddProduct(category);
  }

  @override
  Future<MResult<List<MProduct>>> getProducts() async {
    try {
      final result = await productRef.getProducts();
      if (isNullOrEmpty(result.data)) return MResult.success([]);
      await _syncNewProductToLocal(result.data!);
      return result;
    } catch (e) {
      xLog.e(e);
      return MResult.error(S.text.someThingWentWrong);
    }
  }

  @override
  Future<MResult<bool>> upsertProduct(MProduct category) {
    return productRef.updateCategory(category);
  }

  @override
  Future<MResult<bool>> deleteProduct(MProduct category) {
    return productRef.deleteProduct(category);
  }

  @override
  Future<MResult<Uint8List>> getImage(String id) async {
    return await productRefStorage.getProductImage(id);
  }

  @override
  Future<MResult<bool>> addImage(String id, Uint8List data) async {
    return await productRefStorage.upsertProductImage(id, data);
  }

  Future<void> _syncNewProductToLocal(List<MProduct> listProducts) async {
    for (MProduct product in listProducts) {
      if (product.isNew) {
        await GetIt.I
            .get<NewProductsLocalRepo>()
            .upsert(product.convertToLocalData());
        await _syncImageData(product.convertToLocalData());
      }
    }
  }

  Future<void> _syncImageData(NewProductsEntityData product) async {
    try {
      final images =
          await productRefStorage.getAllInSubFolder(subFolderText: product.id);
      if (isNullOrEmpty(images.data)) return;
      final thumbnailImage =
          await (images.data!.first as List<Reference>).first.getData();
      if (thumbnailImage == null) return;
      await GetIt.I
          .get<NewProductsLocalRepo>()
          .upsert(product.copyWith(image: Value(thumbnailImage)));
    } catch (e) {
      xLog.e(e);
    }
  }
}
