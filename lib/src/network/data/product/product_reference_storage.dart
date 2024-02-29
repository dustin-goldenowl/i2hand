import 'package:flutter/foundation.dart';
import 'package:i2hand/src/localization/localization_utils.dart';
import 'package:i2hand/src/network/firebase/base_storage.dart';
import 'package:i2hand/src/network/firebase/collection/storage_collection.dart';
import 'package:i2hand/src/network/model/common/result.dart';
import 'package:i2hand/src/network/model/product/product.dart';
import 'package:i2hand/src/utils/utils.dart';

class ProductStorageReference extends BaseStorageReference<MProduct> {
  ProductStorageReference() : super(XStorageCollection.products, null);

  Future<MResult<Uint8List>> getProductImage(String id) async {
    try {
      final result = await get("$id.png");
      if (result.data == null) {
        return MResult.error(S.text.someThingWentWrong);
      } else {
        return MResult.success(result.data);
      }
    } catch (e) {
      xLog.e(e);
      return MResult.exception(e);
    }
  }

  Future<MResult<bool>> upsertProductImage(String name, Uint8List image) async {
    try {
      final resultAddFile = await add("$name.png", image);
      return resultAddFile;
    } catch (e) {
      xLog.e(e);
      return MResult.exception(e);
    }
  }

  Future<MResult<List>> getAllProductImages() async {
    try {
      final result = await getAll();
      return MResult.success(result.data);
    } catch (e) {
      return MResult.exception(e);
    }
  }
}
