import 'package:drift/drift.dart';
import 'package:i2hand/src/local/database_app.dart';
import 'package:i2hand/src/network/model/user_product/user_product.dart';

class NewProductsEntity extends Table {
  TextColumn get id => text()();

  @override
  Set<Column> get primaryKey => {id};
}

extension ListNewProductsExt on List<NewProductsEntityData> {
  List<MUserProduct> convertToProductData() {
    List<MUserProduct> listProducts = [];
    for (NewProductsEntityData data in this) {
      final jsonData = data.toJson();
      listProducts.add(MUserProduct.fromJson(jsonData));
    }
    return listProducts;
  }
}
