import 'package:drift/drift.dart';
import 'package:i2hand/src/local/database_app.dart';
import 'package:i2hand/src/network/model/user_product/user_product.dart';

class OrderEntity extends Table {
  TextColumn get id => text()();
  TextColumn get productId => text()();
  IntColumn get epochTime => integer()();
  TextColumn get status => text()();

  @override
  Set<Column> get primaryKey => {id};
}

extension ListPaymentedProductsExt on List<OrderEntityData> {
  List<MUserProduct> convertToUserProductData() {
    List<MUserProduct> listProducts = [];
    for (OrderEntityData data in this) {
      final jsonData = data.toJson();
      listProducts.add(MUserProduct.fromJson(jsonData));
    }
    return listProducts;
  }
}
