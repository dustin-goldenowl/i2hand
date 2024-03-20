import 'package:drift/drift.dart';
import 'package:i2hand/src/local/database_app.dart';
import 'package:i2hand/src/local/repo/wishlist_product/wishlist_product_local_repo.dart';
import 'package:i2hand/src/utils/utils.dart';

class WishlistProductsLocalRepoImpl extends WishlistProductsLocalRepo {
  WishlistProductsLocalRepoImpl(super.database);

  @override
  MultiSelectable<WishlistProductsEntityData> getDetail({required String id}) {
    return (database.select(database.wishlistProductsEntity)
      ..where((product) => product.id.equals(id)));
  }

  @override
  MultiSelectable<WishlistProductsEntityData> getAllDetails({int? limit}) {
    if (limit == null) {
      return database.select(database.wishlistProductsEntity);
    }

    return (database.select(database.wishlistProductsEntity)
      ..limit(limit)
      ..orderBy([(item) => OrderingTerm.desc(item.id)]));
  }

  @override
  Future<WishlistProductsEntityData?> upsert(
      WishlistProductsEntityData entity) async {
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
      await database.delete(database.wishlistProductsEntity).go();
    } catch (error) {
      xLog.w("[error][delete-table] $error");
    }
  }

  Future<WishlistProductsEntityData?> upsertDetail(
      WishlistProductsEntityData entity) async {
    try {
      final oldEntity = await _getDetail(entity.id);
      if (oldEntity != null) {
        await database
            .into(database.wishlistProductsEntity)
            .insertOnConflictUpdate(entity);

        return oldEntity;
      }

      await database.into(database.wishlistProductsEntity).insert(entity);

      return null;
    } catch (error) {
      return null;
    }
  }

  Future<WishlistProductsEntityData?> _getDetail(String id) async {
    try {
      return await (database.select(database.wishlistProductsEntity)
            ..where((tbl) => tbl.id.equals(id)))
          .getSingle();
    } catch (error) {
      return null;
    }
  }

  @override
  Future<WishlistProductsEntityData?> insertDetail(
      WishlistProductsEntityData entity) async {
    try {
      await database
          .into(database.wishlistProductsEntity)
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
      (database.delete(database.wishlistProductsEntity)
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
