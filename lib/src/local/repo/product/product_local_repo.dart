import 'package:drift/drift.dart';
import 'package:i2hand/src/local/database_app.dart';

abstract class ProductsLocalRepo {
  final DatabaseApp database;

  ProductsLocalRepo(this.database);

  Future<ProductsEntityData?> upsert(ProductsEntityData entity);

  Future<ProductsEntityData?> insertDetail(ProductsEntityData entity);

  MultiSelectable<ProductsEntityData> getDetail({required String id});

  MultiSelectable<ProductsEntityData> getDetailByOwnerId(
      {required String userId});

  //Get all records of Details table with limitation and order by desc
  MultiSelectable<ProductsEntityData> getAllDetails({int? limit});

  //Delete all tables
  Future<void> deleteAll();
}
