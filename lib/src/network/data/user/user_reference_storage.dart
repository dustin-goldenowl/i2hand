import 'package:flutter/foundation.dart';
import 'package:i2hand/src/localization/localization_utils.dart';
import 'package:i2hand/src/network/firebase/base_storage.dart';
import 'package:i2hand/src/network/firebase/collection/storage_collection.dart';
import 'package:i2hand/src/network/model/common/result.dart';
import 'package:i2hand/src/network/model/user/user.dart';
import 'package:i2hand/src/utils/utils.dart';

class UsersStorageReference extends BaseStorageReference<MUser> {
  UsersStorageReference() : super(XStorageCollection.users, null);

  Future<MResult<Uint8List>> getUserAvatar(String id) async {
    try {
      final result = await get("$id.jpg");
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

  Future<MResult<bool>> upsertUserAvatar(String id, Uint8List avatar) async {
    try {
      final resultAddFile = await add("$id.jpg", avatar);
      return resultAddFile;
    } catch (e) {
      xLog.e(e);
      return MResult.exception(e);
    }
  }

  Future<MResult<bool>> deleteUserAvatar(String id) async {
    try {
      final result = await get("$id.jpg");
      if (result.data == null) {
        return MResult.success(false);
      } else {
        final MResult<bool> result = await delete("$id.jpg");
        xLog.e(result.data);
        return MResult.success(true);
      }
    } catch (e) {
      xLog.e(e);
      return MResult.exception(e);
    }
  }
}
