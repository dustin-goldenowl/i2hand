import 'package:flutter/foundation.dart';
import 'package:i2hand/src/network/model/common/result.dart';
import 'package:i2hand/src/network/model/product/product.dart';

abstract class ProductRepository {

  Future<MResult<MProduct>> getOrAddProduct(MProduct product);

  Future<MResult<List<MProduct>>> getProducts();

  Future<MResult<bool>> upsertProduct(MProduct product);

  Future<MResult<bool>> deleteProduct(MProduct product);

  Future<MResult<List<Uint8List?>?>> getImage(String id);

  Future<MResult<bool>> addImage({required String id, required Uint8List data, required int index});
}
