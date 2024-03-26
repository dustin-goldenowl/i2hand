import 'package:drift/drift.dart';
import 'package:i2hand/src/local/database_app.dart';
import 'package:i2hand/src/local/repo/cart/cart_local_repo.dart';
import 'package:i2hand/src/utils/utils.dart';

class CartLocalRepoImpl extends CartLocalRepo {
  CartLocalRepoImpl(super.database);

  @override
  MultiSelectable<CartEntityData> getDetail({required String id}) {
    return (database.select(database.cartEntity)
      ..where((product) => product.id.equals(id)));
  }

  @override
  MultiSelectable<CartEntityData> getAllDetails({int? limit}) {
    if (limit == null) {
      return database.select(database.cartEntity);
    }

    return (database.select(database.cartEntity)
      ..limit(limit)
      ..orderBy([(item) => OrderingTerm.desc(item.id)]));
  }

  @override
  Future<CartEntityData?> upsert(
      CartEntityData entity) async {
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
      await database.delete(database.cartEntity).go();
    } catch (error) {
      xLog.w("[error][delete-table] $error");
    }
  }

  Future<CartEntityData?> upsertDetail(
      CartEntityData entity) async {
    try {
      final oldEntity = await _getDetail(entity.id);
      if (oldEntity != null) {
        await database
            .into(database.cartEntity)
            .insertOnConflictUpdate(entity);

        return oldEntity;
      }

      await database.into(database.cartEntity).insert(entity);

      return null;
    } catch (error) {
      return null;
    }
  }

  Future<CartEntityData?> _getDetail(String id) async {
    try {
      return await (database.select(database.cartEntity)
            ..where((tbl) => tbl.id.equals(id)))
          .getSingle();
    } catch (error) {
      return null;
    }
  }

  @override
  Future<CartEntityData?> insertDetail(
      CartEntityData entity) async {
    try {
      await database
          .into(database.cartEntity)
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
      (database.delete(database.cartEntity)
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
