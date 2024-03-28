import 'package:drift/drift.dart';
import 'package:i2hand/src/local/database_app.dart';

abstract class RecentlyViewedLocalRepo {
  final DatabaseApp database;

  RecentlyViewedLocalRepo(this.database);

  Future<RecentlyViewedEntityData?> upsert(RecentlyViewedEntityData entity);

  Future<RecentlyViewedEntityData?> insertDetail(
      RecentlyViewedEntityData entity);

  MultiSelectable<RecentlyViewedEntityData> getDetail({required String id});

  //Get all records of Details table with limitation and order by desc
  MultiSelectable<RecentlyViewedEntityData> getAllDetails({int? limit});

  //Delete all tables
  Future<void> deleteAll();

  //Delete data by id
  Future<void> deleteProductById(String id);

  Future<bool> isContainInDatabase(String id);
}
