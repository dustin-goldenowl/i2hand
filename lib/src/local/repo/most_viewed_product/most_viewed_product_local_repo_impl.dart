import 'package:drift/drift.dart';
import 'package:i2hand/src/local/database_app.dart';
import 'package:i2hand/src/local/repo/most_viewed_product/most_viewed_product_local_repo.dart';
import 'package:i2hand/src/utils/utils.dart';

class MostViewedProductsLocalRepoImpl extends MostViewedProductsLocalRepo {
  MostViewedProductsLocalRepoImpl(super.database);

  @override
  MultiSelectable<MostViewProductsEntityData> getDetail({required String id}) {
    return (database.select(database.mostViewProductsEntity)
      ..where((notes) => notes.id.equals(id)));
  }

  @override
  MultiSelectable<MostViewProductsEntityData> getAllDetails({int? limit}) {
    if (limit == null) {
      return database.select(database.mostViewProductsEntity);
    }

    return (database.select(database.mostViewProductsEntity)
      ..limit(limit)
      ..orderBy([(item) => OrderingTerm.desc(item.id)]));
  }

  @override
  Future<MostViewProductsEntityData?> upsert(MostViewProductsEntityData entity) async {
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
      await database.delete(database.mostViewProductsEntity).go();
    } catch (error) {
      xLog.w("[error][delete-table] $error");
    }
  }

  Future<MostViewProductsEntityData?> upsertDetail(MostViewProductsEntityData entity) async {
    try {
      final oldEntity = await _getDetail(entity.id);
      if (oldEntity != null) {
        await database
            .into(database.mostViewProductsEntity)
            .insertOnConflictUpdate(entity);

        return oldEntity;
      }

      await database.into(database.mostViewProductsEntity).insert(entity);

      return null;
    } catch (error) {
      return null;
    }
  }

  Future<MostViewProductsEntityData?> _getDetail(String id) async {
    try {
      return await (database.select(database.mostViewProductsEntity)
            ..where((tbl) => tbl.id.equals(id)))
          .getSingle();
    } catch (error) {
      return null;
    }
  }

  @override
  Future<MostViewProductsEntityData?> insertDetail(MostViewProductsEntityData entity) async {
    try {
      await database.into(database.mostViewProductsEntity).insertOnConflictUpdate(entity);
      return entity;
    } catch (error) {
      xLog.e("[error - _insertDetail] $error");
      return null;
    }
  }

  @override
  Future<void> deleteNoteById(String id) async {
    try {
      (database.delete(database.mostViewProductsEntity)..where((tbl) => tbl.id.equals(id)))
          .go();
    } catch (error) {
      xLog.e("[error - _deleteNoteById] $error");
    }
  }
}
