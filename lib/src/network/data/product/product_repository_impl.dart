import 'package:drift/drift.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:i2hand/src/local/database_app.dart';
import 'package:i2hand/src/local/repo/most_viewed_product/most_viewed_product_local_repo.dart';
import 'package:i2hand/src/local/repo/new_product/new_product_local_repo.dart';
import 'package:i2hand/src/local/repo/product/product_local_repo.dart';
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
  Future<MResult<MProduct>> getOrAddProduct(MProduct product) {
    return productRef.getOrAddProduct(product);
  }

  @override
  Future<MResult<List<MProduct>>> getProducts() async {
    try {
      final result = await productRef.getProducts();
      if (isNullOrEmpty(result.data)) return MResult.success([]);
      await _syncProductToLocal(result.data!);
      await _syncNewProductToLocal(result.data!);
      await _syncMostViewedProductToLocal(result.data!);
      return result;
    } catch (e) {
      xLog.e(e);
      return MResult.error(S.text.someThingWentWrong);
    }
  }

  @override
  Future<MResult<bool>> upsertProduct(MProduct product) {
    return productRef.updateCategory(product);
  }

  @override
  Future<MResult<bool>> deleteProduct(MProduct product) {
    return productRef.deleteProduct(product);
  }

  @override
  Future<MResult<List<Uint8List?>?>> getImage(String id) async {
    try {
      final images =
          await productRefStorage.getAllInSubFolder(subFolderText: id);
      if (isNullOrEmpty(images.data)) {
        return MResult.error(S.text.someThingWentWrong);
      }
      List<Uint8List?> listImage = [];
      for (Reference image in images.data!.first) {
        listImage.add(await image.getData());
      }
      return MResult.success(listImage);
    } catch (e) {
      xLog.e(e);
      return MResult.error(S.text.someThingWentWrong);
    }
  }

  @override
  Future<MResult<bool>> addImage(
      {required String id, required Uint8List data, required int index}) async {
    return await productRefStorage.addInSubFolder(
        subFolderText: id, data: data, itemText: '$index.jpg');
  }

  Future<void> _syncNewProductToLocal(List<MProduct> listProducts) async {
    for (MProduct product in listProducts) {
      if (product.isNew) {
        await GetIt.I
            .get<NewProductsLocalRepo>()
            .upsert(product.convertToNewProductLocalData());
        await _syncImageData(product.convertToNewProductLocalData());
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

  Future<void> _syncMostViewedProductToLocal(List<MProduct> listProduct) async {
    listProduct.sort((product, compareProduct) =>
        compareProduct.viewed.compareTo(product.viewed));
    int countProduct = 0;
    for (int i = 0; i < listProduct.length; i++) {
      // Get 100 most viewed product
      if (countProduct >= 100) return;
      if (listProduct[i].viewed >= 1000) {
        await GetIt.I
            .get<MostViewedProductsLocalRepo>()
            .upsert(listProduct[i].convertToMostViewedProductLocalData());
        await _syncImageMostView(
            listProduct[i].convertToMostViewedProductLocalData());
      }
    }
  }

  Future<void> _syncImageMostView(MostViewProductsEntityData product) async {
    try {
      final images =
          await productRefStorage.getAllInSubFolder(subFolderText: product.id);
      if (isNullOrEmpty(images.data)) return;
      final thumbnailImage =
          await (images.data!.first as List<Reference>).first.getData();
      if (thumbnailImage == null) return;
      await GetIt.I
          .get<MostViewedProductsLocalRepo>()
          .upsert(product.copyWith(image: Value(thumbnailImage)));
    } catch (e) {
      xLog.e(e);
    }
  }

  Future<void> _syncProductToLocal(List<MProduct> listProducts) async {
    for (MProduct product in listProducts) {
      await GetIt.I
          .get<ProductsLocalRepo>()
          .upsert(product.convertToProductLocalData());
      await _syncProductImageData(product.convertToProductLocalData());
    }
  }

  Future<void> _syncProductImageData(ProductsEntityData product) async {
    try {
      final images =
          await productRefStorage.getAllInSubFolder(subFolderText: product.id);
      if (isNullOrEmpty(images.data)) return;
      final thumbnailImage =
          await (images.data!.first as List<Reference>).first.getData();
      if (thumbnailImage == null) return;
      await GetIt.I
          .get<ProductsLocalRepo>()
          .upsert(product.copyWith(image: Value(thumbnailImage)));
    } catch (e) {
      xLog.e(e);
    }
  }
}
