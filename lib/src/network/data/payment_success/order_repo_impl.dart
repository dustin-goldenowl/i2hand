import 'package:get_it/get_it.dart';
import 'package:i2hand/src/local/repo/order/order_local_repo.dart';
import 'package:i2hand/src/localization/localization_utils.dart';
import 'package:i2hand/src/network/data/payment_success/order_reference.dart';
import 'package:i2hand/src/network/data/payment_success/order_repository.dart';
import 'package:i2hand/src/network/model/common/result.dart';
import 'package:i2hand/src/network/model/order/order.dart';
import 'package:i2hand/src/utils/utils.dart';

class OrderRepositoryImpl extends OrderRepository {
  final orderRef = OrderReference();

  @override
  Future<MResult<MOrder>> getOrAddOrder(MOrder order) async {
    return await orderRef.getOrAddOrder(order);
  }

  @override
  Future<MResult<List<MOrder>>> getOrders() async {
    try {
      final result = await orderRef.getOrders();
      if (isNullOrEmpty(result.data)) return MResult.success([]);
      await _syncOrderToLocal(result.data!);
      return result;
    } catch (e) {
      xLog.e(e);
      return MResult.error(S.text.someThingWentWrong);
    }
  }

  @override
  Future<MResult<bool>> deleteOrder(MOrder order) async {
    return await orderRef.deleteOrder(order);
  }

  Future<void> _syncOrderToLocal(List<MOrder> listProducts) async {
    for (MOrder product in listProducts) {
      await GetIt.I
          .get<OrderLocalRepo>()
          .upsert(product.convertToOrderLocalData());
    }
  }
}
