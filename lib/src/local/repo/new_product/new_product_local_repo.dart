import 'package:drift/drift.dart';
import 'package:i2hand/src/local/database_app.dart';

abstract class NewProductsLocalRepo {
  final DatabaseApp database;

  NewProductsLocalRepo(this.database);

  Future<NewProductsEntityData?> upsert(NewProductsEntityData entity);

  /// Upsert a value summarized by day into: Month table
  Future<NewProductsEntityData?> insertDetail(NewProductsEntityData entity);

  MultiSelectable<NewProductsEntityData> getDetail({required String id});

  //Get all records of Details table with limitation and order by desc
  MultiSelectable<NewProductsEntityData> getAllDetails({int? limit});

  //Delete all tables
  Future<void> deleteAll();

  //Delete data by id
  Future<void> deleteNoteById(String id);
}
