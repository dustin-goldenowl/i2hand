import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:i2hand/src/localization/localization_utils.dart';
import 'package:i2hand/src/network/data/user/user_reference.dart';
import 'package:i2hand/src/network/data/user/user_reference_storage.dart';
import 'package:i2hand/src/network/data/user/user_repository.dart';
import 'package:i2hand/src/network/model/common/result.dart';
import 'package:i2hand/src/network/model/user/user.dart';
import 'package:i2hand/src/service/link.dart';
import 'package:i2hand/src/utils/utils.dart';

class UserRepositoryImpl extends UserRepository {
  final usersRef = UserReference();
  final usersRefStorage = UsersStorageReference();
  @override
  Future<MResult<MUser>> getUser() async {
    try {
      final result = FirebaseAuth.instance.currentUser;
      if (result == null) {
        return MResult.error('Not user login');
      }
      final user =
          MUser(id: result.uid, email: result.email, name: result.displayName);
      return MResult.success(user);
    } catch (e) {
      return MResult.exception(e);
    }
  }

  @override
  Future<MResult<MUser>> getOrAddUser(MUser user) {
    return usersRef.getOrAddUser(user);
  }

  @override
  Future<MResult<List<MUser>>> getUsers() {
    return usersRef.getUsers();
  }

  @override
  Future<MResult<bool>> upsertUser(MUser user) {
    return usersRef.updateUser(user);
  }

  @override
  Future<MResult<bool>> deleteUser(MUser user) {
    return usersRef.deleteUser(user);
  }

  @override
  Future<MResult<Uint8List>> getImage(String id) async {
    return await usersRefStorage.getUserAvatar(id);
  }

  @override
  Future<MResult<bool>> addImage(String id, Uint8List data) async {
    return await usersRefStorage.upsertUserAvatar(id, data);
  }

  @override
  Future<MResult<bool>> deleteImage(String id) async {
    return await usersRefStorage.deleteUserAvatar(id);
  }

  @override
  Future<MResult<String>> eKYCAccount() async {
    final headers = {
      'Accept-Language': 'en',
      'Authorization':
          'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzEwMzk4NjQwLCJpYXQiOjE3MTAzMTIyNDAsImp0aSI6ImNiM2U4ZWQwZGZiODQyMDRhNzFkYmFjZTBhYjNhZjM4IiwidXNlcl9pZCI6MTA3OH0.skicW4xyvbNz2QkEzBInvuTP0RQ8oNd_66xqFLmcwUA',
      'Content-Type': 'application/json'
    };
    return http
        .post(Uri.parse(AppLink.urlEKYC), headers: headers)
        .then((http.Response response) {
      final String jsonBody = response.body;
      final int statusCode = response.statusCode;

      // Code 201 <=> Created form
      if (statusCode != 201 || isNullOrEmpty(jsonBody)) {
        xLog.e(response.reasonPhrase);
        throw Exception(S.text.someThingWentWrong);
      }

      const JsonDecoder decoder = JsonDecoder();
      final data = decoder.convert(jsonBody);

      return MResult.success(data['form_url']);
    });
  }
}
