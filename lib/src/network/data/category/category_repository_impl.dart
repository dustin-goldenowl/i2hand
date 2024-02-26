import 'package:flutter/foundation.dart';
import 'package:i2hand/src/network/data/category/category_reference.dart';
import 'package:i2hand/src/network/data/category/category_reference_storage.dart';
import 'package:i2hand/src/network/data/category/category_repository.dart';
import 'package:i2hand/src/network/model/category/category.dart';
import 'package:i2hand/src/network/model/common/result.dart';

class CategoryRepositoryImpl extends CategoryRepository {
  final categoryRef = CategoryReference();
  final categoryRefStorage = CategoryStorageReference();

  @override
  Future<MResult<MCategory>> getOrAddCategory(MCategory category) {
    return categoryRef.getOrAddCategory(category);
  }

  @override
  Future<MResult<List<MCategory>>> getCategories() {
    return categoryRef.getCategories();
  }

  @override
  Future<MResult<bool>> upsertCategory(MCategory category) {
    return categoryRef.updateCategory(category);
  }

  @override
  Future<MResult<bool>> deleteCategory(MCategory category) {
    return categoryRef.deleteCategory(category);
  }

  @override
  Future<MResult<Uint8List>> getImage(String name) async {
    return await categoryRefStorage.getCategoriesImage(name);
  }

  @override
  Future<MResult<bool>> addImage(String name, Uint8List data) async {
    return await categoryRefStorage.upsertCategoriesImage(name, data);
  }
}
