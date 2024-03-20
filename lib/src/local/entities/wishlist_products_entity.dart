import 'package:drift/drift.dart';
import 'package:i2hand/src/local/database_app.dart';
import 'package:i2hand/src/network/model/user_product/user_product.dart';

class WishlistProductsEntity extends Table {
  TextColumn get id => text()();

  @override
  Set<Column> get primaryKey => {id};
}

extension ListWishlistProductsExt on List<WishlistProductsEntityData> {
  List<MUserProduct> convertToUserProductData() {
    List<MUserProduct> listProducts = [];
    for (WishlistProductsEntityData data in this) {
      final jsonData = data.toJson();
      listProducts.add(MUserProduct.fromJson(jsonData));
    }
    return listProducts;
  }
}
