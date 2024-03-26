import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:i2hand/src/network/firebase/base_collection.dart';
import 'package:i2hand/src/network/firebase/collection/collection.dart';
import 'package:i2hand/src/network/model/common/result.dart';
import 'package:i2hand/src/network/model/user_product/user_product.dart';
import 'package:i2hand/src/utils/utils.dart';

class CartReference extends BaseCollectionReference<MUserProduct> {
  CartReference()
      : super(
          XCollection.cart,
          getObjectId: (e) => e.id,
          setObjectId: (e, id) => e.copyWith(id: id),
        );

  Future<MResult<MUserProduct>> getOrAddCartProduct(MUserProduct product) async {
    try {
      final result = await get(product.id);
      if (result.isError == false) {
        return result;
      } else {
        final MResult<MUserProduct> result = await set(product);
        return MResult.success(result.data);
      }
    } catch (e) {
      return MResult.exception(e);
    }
  }

  Future<MResult<List<MUserProduct>>> getCartProducts() async {
    try {
      final QuerySnapshot<MUserProduct> query =
          await ref.get().timeout(const Duration(seconds: 10));
      final docs = query.docs.map((e) => e.data()).toList();
      return MResult.success(docs);
    } catch (e) {
      xLog.e(e);
      return MResult.exception(e);
    }
  }

  Future<MResult<bool>> deleteCartProduct(MUserProduct product) async {
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
