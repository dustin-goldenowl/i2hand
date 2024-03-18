import 'package:drift/drift.dart';
import 'package:i2hand/src/local/database_app.dart';

abstract class WishlistProductsLocalRepo {
  final DatabaseApp database;

  WishlistProductsLocalRepo(this.database);

  Future<WishlistProductsEntityData?> upsert(WishlistProductsEntityData entity);

  Future<WishlistProductsEntityData?> insertDetail(
      WishlistProductsEntityData entity);

  MultiSelectable<WishlistProductsEntityData> getDetail({required String id});

  //Get all records of Details table with limitation and order by desc
  MultiSelectable<WishlistProductsEntityData> getAllDetails({int? limit});

  //Delete all tables
  Future<void> deleteAll();

  //Delete data by id
  Future<void> deleteProductById(String id);

  Future<bool> isContainInDatabase(String id);
}
