import 'package:drift/drift.dart';
import 'package:i2hand/src/local/database_app.dart';
import 'package:i2hand/src/network/model/recently_viewed/recently_viewed.dart';
import 'package:i2hand/src/utils/utils.dart';

class RecentlyViewedEntity extends Table {
  TextColumn get id => text()();
  BlobColumn get image => blob()();
  IntColumn get time => integer()();

  @override
  Set<Column> get primaryKey => {id};
}

extension ListRecentlyViewedsExt on List<RecentlyViewedEntityData> {
  List<MRecentlyViewedProduct> convertToRecentlyProductData() {
    List<MRecentlyViewedProduct> listProducts = [];
    for (RecentlyViewedEntityData data in this) {
      final jsonData = data.toJson();
      if (!isNullOrEmpty(jsonData['image'])) {
        jsonData['image'] =
            (jsonData['image'] as Uint8List).map((e) => e.toString()).toList();
      }
      listProducts.add(MRecentlyViewedProduct.fromJson(jsonData));
    }
    return listProducts;
  }
}
