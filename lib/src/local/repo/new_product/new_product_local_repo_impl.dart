import 'package:drift/drift.dart';
import 'package:i2hand/src/local/database_app.dart';
import 'package:i2hand/src/local/repo/new_product/new_product_local_repo.dart';
import 'package:i2hand/src/utils/utils.dart';

class NewProductsLocalRepoImpl extends NewProductsLocalRepo {
  NewProductsLocalRepoImpl(super.database);

  @override
  MultiSelectable<NewProductsEntityData> getDetail({required String id}) {
    return (database.select(database.newProductsEntity)
      ..where((notes) => notes.id.equals(id)));
  }

  @override
  MultiSelectable<NewProductsEntityData> getAllDetails({int? limit}) {
    if (limit == null) {
      return database.select(database.newProductsEntity);
    }

    return (database.select(database.newProductsEntity)
      ..limit(limit)
      ..orderBy([(item) => OrderingTerm.desc(item.id)]));
  }

  @override
  Future<NewProductsEntityData?> upsert(NewProductsEntityData entity) async {
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
      await database.delete(database.newProductsEntity).go();
    } catch (error) {
      xLog.w("[error][delete-table] $error");
    }
  }

  Future<NewProductsEntityData?> upsertDetail(NewProductsEntityData entity) async {
    try {
      final oldEntity = await _getDetail(entity.id);
      if (oldEntity != null) {
        await database
            .into(database.newProductsEntity)
            .insertOnConflictUpdate(entity);

        return oldEntity;
      }

      await database.into(database.newProductsEntity).insert(entity);

      return null;
    } catch (error) {
      return null;
    }
  }

  Future<NewProductsEntityData?> _getDetail(String id) async {
    try {
      return await (database.select(database.newProductsEntity)
            ..where((tbl) => tbl.id.equals(id)))
          .getSingle();
    } catch (error) {
      return null;
    }
  }

  @override
  Future<NewProductsEntityData?> insertDetail(NewProductsEntityData entity) async {
    try {
      await database.into(database.newProductsEntity).insertOnConflictUpdate(entity);
      return entity;
    } catch (error) {
      xLog.e("[error - _insertDetail] $error");
      return null;
    }
  }

  @override
  Future<void> deleteNoteById(String id) async {
    try {
      (database.delete(database.newProductsEntity)..where((tbl) => tbl.id.equals(id)))
          .go();
    } catch (error) {
      xLog.e("[error - _deleteNoteById] $error");
    }
  }
}
