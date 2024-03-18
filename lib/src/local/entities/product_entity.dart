import 'package:drift/drift.dart';
import 'package:i2hand/src/local/database_app.dart';
import 'package:i2hand/src/network/model/product/product.dart';
import 'package:i2hand/src/utils/utils.dart';

class ProductsEntity extends Table {
  TextColumn get id => text()();
  TextColumn get title => text()();
  TextColumn get province => text()();
  RealColumn get price => real()();
  BlobColumn get image => blob().nullable()();
  TextColumn get owner => text()();
  DateTimeColumn get time => dateTime().nullable()();
  IntColumn get viewed => integer()();

  @override
  Set<Column> get primaryKey => {id};
}

extension ListProductsExt on List<ProductsEntityData> {
  List<MProduct> convertToProductData() {
    List<MProduct> listProducts = [];
    for (ProductsEntityData data in this) {
      final jsonData = data.toJson();
      if (!isNullOrEmpty(jsonData['image'])) {
        jsonData['image'] =
            (jsonData['image'] as Uint8List).map((e) => e.toString()).toList();
      }
      listProducts.add(MProduct.fromJson(jsonData));
    }
    return listProducts;
  }
}
