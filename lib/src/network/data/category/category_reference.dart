import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:i2hand/src/localization/localization_utils.dart';
import 'package:i2hand/src/network/firebase/base_collection.dart';
import 'package:i2hand/src/network/firebase/collection/collection.dart';
import 'package:i2hand/src/network/model/category/category.dart';
import 'package:i2hand/src/network/model/common/result.dart';
import 'package:i2hand/src/utils/utils.dart';

class CategoryReference extends BaseCollectionReference<MCategory> {
  CategoryReference()
      : super(
          XCollection.category,
          getObjectId: (e) => e.name,
          setObjectId: (e, name) => e.copyWith(name: name),
        );

  Future<MResult<MCategory>> getOrAddCategory(MCategory category) async {
    try {
      final result = await get(category.name);
      if (result.isError == false) {
        return result;
      } else {
        final MResult<MCategory> result = await set(category);
        return MResult.success(result.data);
      }
    } catch (e) {
      return MResult.exception(e);
    }
  }

  Future<MResult<bool>> updateCategory(MCategory category) async {
    try {
      final result = await update(category.name, category.toJson());
      if (result.isError == true) {
        return MResult.error(S.text.someThingWentWrong);
      } else {
        return MResult.success(true);
      }
    } catch (e) {
      return MResult.exception(e);
    }
  }

  Future<MResult<List<MCategory>>> getCategories() async {
    try {
      final QuerySnapshot<MCategory> query =
          await ref.get().timeout(const Duration(seconds: 10));
      final docs = query.docs.map((e) {
        return e.data();
      }).toList();
      return MResult.success(docs);
    } catch (e) {
      xLog.e(e);
      return MResult.exception(e);
    }
  }

  Future<MResult<bool>> deleteCategory(MCategory category) async {
    try {
      final result = await delete(category);
      if (result.isError == true) {
        return MResult.exception(false);
      }
      return result;
    } catch (e) {
      xLog.e(e);
      return MResult.exception(e);
    }
  }
}
