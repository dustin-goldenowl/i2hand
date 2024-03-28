import 'package:drift/drift.dart';
import 'package:i2hand/src/local/database_app.dart';

abstract class CartLocalRepo {
  final DatabaseApp database;

  CartLocalRepo(this.database);

  Future<CartEntityData?> upsert(CartEntityData entity);

  Future<CartEntityData?> insertDetail(
      CartEntityData entity);

  MultiSelectable<CartEntityData> getDetail({required String id});

  //Get all records of Details table with limitation and order by desc
  MultiSelectable<CartEntityData> getAllDetails({int? limit});

  //Delete all tables
  Future<void> deleteAll();

  //Delete data by id
  Future<void> deleteProductById(String id);

  Future<bool> isContainInDatabase(String id);
}
