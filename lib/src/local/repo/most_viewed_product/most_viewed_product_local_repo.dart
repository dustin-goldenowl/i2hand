import 'package:drift/drift.dart';
import 'package:i2hand/src/local/database_app.dart';

abstract class MostViewedProductsLocalRepo {
  final DatabaseApp database;

  MostViewedProductsLocalRepo(this.database);

  Future<MostViewProductsEntityData?> upsert(MostViewProductsEntityData entity);

  Future<MostViewProductsEntityData?> insertDetail(MostViewProductsEntityData entity);

  MultiSelectable<MostViewProductsEntityData> getDetail({required String id});

  //Get all records of Details table with limitation and order by desc
  MultiSelectable<MostViewProductsEntityData> getAllDetails({int? limit});

  //Delete all tables
  Future<void> deleteAll();

  //Delete data by id
  Future<void> deleteNoteById(String id);
}
