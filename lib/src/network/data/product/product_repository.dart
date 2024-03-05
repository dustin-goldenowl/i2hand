import 'package:flutter/foundation.dart';
import 'package:i2hand/src/network/model/common/result.dart';
import 'package:i2hand/src/network/model/product/product.dart';

abstract class ProductRepository {

  Future<MResult<MProduct>> getOrAddProduct(MProduct category);

  Future<MResult<List<MProduct>>> getProducts();

  Future<MResult<bool>> upsertProduct(MProduct category);

  Future<MResult<bool>> deleteProduct(MProduct category);

  Future<MResult<List<Uint8List?>?>> getImage(String id);

  Future<MResult<bool>> addImage(String id, Uint8List data);
}
