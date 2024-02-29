import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:i2hand/src/localization/localization_utils.dart';
import 'package:i2hand/src/network/firebase/base_collection.dart';
import 'package:i2hand/src/network/firebase/collection/collection.dart';
import 'package:i2hand/src/network/model/common/result.dart';
import 'package:i2hand/src/network/model/product/product.dart';
import 'package:i2hand/src/utils/utils.dart';

class ProductReference extends BaseCollectionReference<MProduct> {
  ProductReference()
      : super(
          XCollection.products,
          getObjectId: (e) => e.id,
          setObjectId: (e, id) => e.copyWith(id: id),
        );

  Future<MResult<MProduct>> getOrAddProduct(MProduct product) async {
    try {
      final result = await get(product.id);
      if (result.isError == false) {
        return result;
      } else {
        final MResult<MProduct> result = await set(product);
        return MResult.success(result.data);
      }
    } catch (e) {
      return MResult.exception(e);
    }
  }

  Future<MResult<bool>> updateCategory(MProduct product) async {
    try {
      final result = await update(product.id, product.toJson());
      if (result.isError == true) {
        return MResult.error(S.text.someThingWentWrong);
      } else {
        return MResult.success(true);
      }
    } catch (e) {
      return MResult.exception(e);
    }
  }

  Future<MResult<List<MProduct>>> getProducts() async {
    try {
      final QuerySnapshot<MProduct> query =
          await ref.get().timeout(const Duration(seconds: 10));
      final docs = query.docs.map((e) {
        return e.data();
      }).toList();
      return MResult.success(docs);
    } catch (e) {
      xLog.e(e);
      return MResult.exception(e);
    }
  }

  Future<MResult<bool>> deleteProduct(MProduct product) async {
    try {
      final result = await delete(product);
      if (result.isError == true) {
        return MResult.exception(false);
      }
      return result;
    } catch (e) {
      xLog.e(e);
      return MResult.exception(e);
    }
  }
}
