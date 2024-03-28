import 'package:drift/drift.dart';
import 'package:i2hand/src/local/database_app.dart';
import 'package:i2hand/src/network/model/order/order.dart';

class OrderEntity extends Table {
  TextColumn get id => text()();
  TextColumn get productId => text()();
  IntColumn get createdOrderTime => integer()();
  TextColumn get status => text()();

  @override
  Set<Column> get primaryKey => {id};
}

extension ListPaymentedProductsExt on List<OrderEntityData> {
  List<MOrder> convertToOrderData() {
    List<MOrder> listProducts = [];
    for (OrderEntityData data in this) {
      final jsonData = data.toJson();
      listProducts.add(MOrder.fromJson(jsonData));
    }
    return listProducts;
  }
}
