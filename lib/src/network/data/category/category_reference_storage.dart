import 'package:flutter/foundation.dart';
import 'package:i2hand/src/localization/localization_utils.dart';
import 'package:i2hand/src/network/firebase/base_storage.dart';
import 'package:i2hand/src/network/firebase/collection/storage_collection.dart';
import 'package:i2hand/src/network/model/common/result.dart';
import 'package:i2hand/src/network/model/user/user.dart';
import 'package:i2hand/src/utils/utils.dart';

class CategoryStorageReference extends BaseStorageReference<MUser> {
  CategoryStorageReference() : super(XStorageCollection.categories, null);

  Future<MResult<Uint8List>> getCategoriesImage(String name) async {
    try {
      final result = await get("$name.png");
      if (result.data == null) {
        return MResult.error(S.text.someThingWentWrong);
      } else {
        return MResult.success(result.data);
      }
    } catch (e) {
      xLog.e(e);
      return MResult.exception(e);
    }
  }

  Future<MResult<bool>> upsertCategoriesImage(
      String name, Uint8List image) async {
    try {
      final resultAddFile = await add("$name.png", image);
      return resultAddFile;
    } catch (e) {
      xLog.e(e);
      return MResult.exception(e);
    }
  }
}
