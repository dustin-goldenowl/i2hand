import 'package:i2hand/src/network/model/common/result.dart';
import 'package:i2hand/src/network/model/order/order.dart';

abstract class OrderRepository {
  Future<MResult<MOrder>> getOrAddOrder(MOrder order);

  Future<MResult<List<MOrder>>> getOrders();

  Future<MResult<bool>> deleteOrder(MOrder order);
}
