import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:get_it/get_it.dart';
import 'package:i2hand/src/local/entities/cart_entity.dart';
import 'package:i2hand/src/local/entities/most_viewed_products_entity.dart';
import 'package:i2hand/src/local/entities/new_products_entity.dart';
import 'package:i2hand/src/local/entities/order_entity.dart';
import 'package:i2hand/src/local/entities/product_entity.dart';
import 'package:i2hand/src/local/entities/recently_viewed_entity.dart';
import 'package:i2hand/src/local/entities/wishlist_products_entity.dart';
import 'package:i2hand/src/local/repo/cart/cart_local_repo.dart';
import 'package:i2hand/src/local/repo/most_viewed_product/most_viewed_product_local_repo.dart';
import 'package:i2hand/src/local/repo/new_product/new_product_local_repo.dart';
import 'package:i2hand/src/local/repo/order/order_local_repo.dart';
import 'package:i2hand/src/local/repo/product/product_local_repo.dart';
import 'package:i2hand/src/local/repo/recently_viewed/recently_viewed_local_repo.dart';
import 'package:i2hand/src/local/repo/wishlist_product/wishlist_product_local_repo.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
part 'database_app.g.dart';

//Run this comment to generate new schema:
//flutter pub run build_runner build --delete-conflicting-outputs
@DriftDatabase(tables: [
  NewProductsEntity,
  MostViewProductsEntity,
  WishlistProductsEntity,
  ProductsEntity,
  OrderEntity,
  CartEntity,
  RecentlyViewedEntity,
])
class DatabaseApp extends _$DatabaseApp {
  DatabaseApp() : super(_openConnection());

  @override
  int get schemaVersion => 1;
  Future<void> deleteAll() async {
    await GetIt.I.get<NewProductsLocalRepo>().deleteAll();
    await GetIt.I.get<MostViewedProductsLocalRepo>().deleteAll();
    await GetIt.I.get<WishlistProductsLocalRepo>().deleteAll();
    await GetIt.I.get<ProductsLocalRepo>().deleteAll();
    await GetIt.I.get<OrderLocalRepo>().deleteAll();
    await GetIt.I.get<CartLocalRepo>().deleteAll();
  }

  Future<void> clearUserDatabase() async {
    await GetIt.I.get<OrderLocalRepo>().deleteAll();
    await GetIt.I.get<CartLocalRepo>().deleteAll();
    await GetIt.I.get<WishlistProductsLocalRepo>().deleteAll();
    await GetIt.I.get<RecentlyViewedLocalRepo>().deleteAll();
  }
}

LazyDatabase _openConnection() {
  // the LazyDatabase util lets us find the right location for the file async.
  return LazyDatabase(() async {
    // The database saves into the support directory, doesn't expose to user
    // Review carefully before modifying it
    final dbFolder = await getApplicationSupportDirectory();
    final file = File(p.join(dbFolder.path, 'safebump.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}
