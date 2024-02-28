import 'package:flutter/foundation.dart';
import 'package:i2hand/src/network/model/category/category.dart';
import 'package:i2hand/src/network/model/common/result.dart';

abstract class CategoryRepository {

  Future<MResult<MCategory>> getOrAddCategory(MCategory category);

  Future<MResult<List<MCategory>>> getCategories();

  Future<MResult<bool>> upsertCategory(MCategory category);

  Future<MResult<bool>> deleteCategory(MCategory category);

  Future<MResult<Uint8List>> getImage(String name);

  Future<MResult<bool>> addImage(String name, Uint8List data);
}
