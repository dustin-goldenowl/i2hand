import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:i2hand/src/network/firebase/base_collection.dart';
import 'package:i2hand/src/network/firebase/collection/collection.dart';
import 'package:i2hand/src/network/model/common/result.dart';
import 'package:i2hand/src/network/model/order/order.dart';
import 'package:i2hand/src/utils/utils.dart';

class OrderReference extends BaseCollectionReference<MOrder> {
  OrderReference()
      : super(
          XCollection.order,
          getObjectId: (e) => e.id,
          setObjectId: (e, id) => e.copyWith(id: id),
        );

  Future<MResult<MOrder>> getOrAddOrder(MOrder order) async {
    try {
      final result = await get(order.id);
      if (result.isError == false) {
        return result;
      } else {
        final MResult<MOrder> result = await set(order);
        return MResult.success(result.data);
      }
    } catch (e) {
      return MResult.exception(e);
    }
  }

  Future<MResult<List<MOrder>>> getOrders() async {
    try {
      final QuerySnapshot<MOrder> query =
          await ref.get().timeout(const Duration(seconds: 10));
      final docs = query.docs.map((e) => e.data()).toList();
      return MResult.success(docs);
    } catch (e) {
      xLog.e(e);
      return MResult.exception(e);
    }
  }

  Future<MResult<bool>> deleteOrder(MOrder order) async {
    try {
      final result = await delete(order);
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
