import 'package:drift/drift.dart';
import 'package:i2hand/src/local/database_app.dart';
import 'package:i2hand/src/local/repo/recently_viewed/recently_viewed_local_repo.dart';
import 'package:i2hand/src/utils/utils.dart';

class RecentlyViewedLocalRepoImpl extends RecentlyViewedLocalRepo {
  RecentlyViewedLocalRepoImpl(super.database);

  @override
  MultiSelectable<RecentlyViewedEntityData> getDetail({required String id}) {
    return (database.select(database.recentlyViewedEntity)
      ..where((product) => product.id.equals(id)));
  }

  @override
  MultiSelectable<RecentlyViewedEntityData> getAllDetails({int? limit}) {
    if (limit == null) {
      return database.select(database.recentlyViewedEntity);
    }

    return (database.select(database.recentlyViewedEntity)
      ..limit(limit)
      ..orderBy([(item) => OrderingTerm.desc(item.id)]));
  }

  @override
  Future<RecentlyViewedEntityData?> upsert(
      RecentlyViewedEntityData entity) async {
    try {
      await upsertDetail(entity);
      return entity;
    } catch (error) {
      return null;
    }
  }

  @override
  Future<void> deleteAll() async {
    try {
      await database.delete(database.recentlyViewedEntity).go();
    } catch (error) {
      xLog.w("[error][delete-table] $error");
    }
  }

  Future<RecentlyViewedEntityData?> upsertDetail(
      RecentlyViewedEntityData entity) async {
    try {
      final oldEntity = await _getDetail(entity.id);
      if (oldEntity != null) {
        await database
            .into(database.recentlyViewedEntity)
            .insertOnConflictUpdate(entity);

        return oldEntity;
      }

      await database.into(database.recentlyViewedEntity).insert(entity);

      return null;
    } catch (error) {
      return null;
    }
  }

  Future<RecentlyViewedEntityData?> _getDetail(String id) async {
    try {
      return await (database.select(database.recentlyViewedEntity)
            ..where((tbl) => tbl.id.equals(id)))
          .getSingle();
    } catch (error) {
      return null;
    }
  }

  @override
  Future<RecentlyViewedEntityData?> insertDetail(
      RecentlyViewedEntityData entity) async {
    try {
      await database
          .into(database.recentlyViewedEntity)
          .insertOnConflictUpdate(entity);
      return entity;
    } catch (error) {
      xLog.e("[error - _insertDetail] $error");
      return null;
    }
  }

  @override
  Future<void> deleteProductById(String id) async {
    try {
      final isContained = await isContainInDatabase(id);
      if (!isContained) return;
      (database.delete(database.recentlyViewedEntity)
            ..where((tbl) => tbl.id.equals(id)))
          .go();
    } catch (error) {
      xLog.e("[error - deleteProductById] $error");
    }
  }

  @override
  Future<bool> isContainInDatabase(String id) async {
    try {
      final entityData = await _getDetail(id);
      if (entityData != null) {
        return true;
      }
      return false;
    } catch (error) {
      xLog.e("[error - isContainInDatabase] $error");
      return false;
    }
  }
}
