import 'package:drift/drift.dart';
import 'package:i2hand/src/local/database_app.dart';
import 'package:i2hand/src/local/repo/product/product_local_repo.dart';
import 'package:i2hand/src/utils/utils.dart';

class ProductsLocalRepoImpl extends ProductsLocalRepo {
  ProductsLocalRepoImpl(super.database);

  @override
  MultiSelectable<ProductsEntityData> getDetail({required String id}) {
    return (database.select(database.productsEntity)
      ..where((product) => product.id.equals(id)));
  }

  @override
  MultiSelectable<ProductsEntityData> getAllDetails({int? limit}) {
    if (limit == null) {
      return database.select(database.productsEntity);
    }

    return (database.select(database.productsEntity)
      ..limit(limit)
      ..orderBy([(item) => OrderingTerm.desc(item.id)]));
  }

  @override
  Future<ProductsEntityData?> upsert(ProductsEntityData entity) async {
    try {
      await upsertDetail(entity);
      return entity;
    } catch (error) {
      xLog.e(error);
      return null;
    }
  }

  @override
  Future<void> deleteAll() async {
    try {
      await database.delete(database.productsEntity).go();
    } catch (error) {
      xLog.w("[error][delete-table] $error");
    }
  }

  Future<ProductsEntityData?> upsertDetail(ProductsEntityData entity) async {
    try {
      final oldEntity = await _getDetail(entity.id);
      if (oldEntity != null) {
        await database
            .into(database.productsEntity)
            .insertOnConflictUpdate(entity);

        return oldEntity;
      }

      await database.into(database.productsEntity).insert(entity);

      return null;
    } catch (error) {
      return null;
    }
  }

  Future<ProductsEntityData?> _getDetail(String id) async {
    try {
      return await (database.select(database.productsEntity)
            ..where((tbl) => tbl.id.equals(id)))
          .getSingle();
    } catch (error) {
      return null;
    }
  }

  @override
  Future<ProductsEntityData?> insertDetail(ProductsEntityData entity) async {
    try {
      await database
          .into(database.productsEntity)
          .insertOnConflictUpdate(entity);
      return entity;
    } catch (error) {
      xLog.e("[error - _insertDetail] $error");
      return null;
    }
  }

  @override
  MultiSelectable<ProductsEntityData> getDetailByOwnerId({required String userId}) {
    return (database.select(database.productsEntity)
      ..where((product) => product.owner.equals(userId)));
  }
}
