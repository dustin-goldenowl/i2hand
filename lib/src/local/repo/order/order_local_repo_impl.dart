import 'package:drift/drift.dart';
import 'package:i2hand/src/local/database_app.dart';
import 'package:i2hand/src/local/repo/order/order_local_repo.dart';
import 'package:i2hand/src/utils/utils.dart';

class OrderLocalRepoImpl extends OrderLocalRepo {
  OrderLocalRepoImpl(super.database);

  @override
  MultiSelectable<OrderEntityData> getDetail({required String id}) {
    return (database.select(database.orderEntity)
      ..where((product) => product.id.equals(id)));
  }

  @override
  MultiSelectable<OrderEntityData> getAllDetails({int? limit}) {
    if (limit == null) {
      return database.select(database.orderEntity);
    }

    return (database.select(database.orderEntity)
      ..limit(limit)
      ..orderBy([(item) => OrderingTerm.desc(item.id)]));
  }

  @override
  Future<OrderEntityData?> upsert(OrderEntityData entity) async {
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
      await database.delete(database.orderEntity).go();
    } catch (error) {
      xLog.w("[error][delete-table] $error");
    }
  }

  Future<OrderEntityData?> upsertDetail(OrderEntityData entity) async {
    try {
      final oldEntity = await _getDetail(entity.id);
      if (oldEntity != null) {
        await database
            .into(database.orderEntity)
            .insertOnConflictUpdate(entity);

        return oldEntity;
      }

      await database.into(database.orderEntity).insert(entity);

      return null;
    } catch (error) {
      return null;
    }
  }

  Future<OrderEntityData?> _getDetail(String id) async {
    try {
      return await (database.select(database.orderEntity)
            ..where((tbl) => tbl.id.equals(id)))
          .getSingle();
    } catch (error) {
      return null;
    }
  }

  @override
  Future<OrderEntityData?> insertDetail(OrderEntityData entity) async {
    try {
      await database.into(database.orderEntity).insertOnConflictUpdate(entity);
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
      (database.delete(database.orderEntity)..where((tbl) => tbl.id.equals(id)))
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
