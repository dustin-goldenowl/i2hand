import 'package:drift/drift.dart';
import 'package:i2hand/src/local/database_app.dart';

abstract class OrderLocalRepo {
  final DatabaseApp database;

  OrderLocalRepo(this.database);

  Future<OrderEntityData?> upsert(OrderEntityData entity);

  Future<OrderEntityData?> insertDetail(OrderEntityData entity);

  MultiSelectable<OrderEntityData> getDetail({required String id});

  //Get all records of Details table with limitation and order by desc
  MultiSelectable<OrderEntityData> getAllDetails({int? limit});

  //Delete all tables
  Future<void> deleteAll();

  //Delete data by id
  Future<void> deleteProductById(String id);

  Future<bool> isContainInDatabase(String id);
}
