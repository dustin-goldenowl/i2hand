// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MUser _$MUserFromJson(Map<String, dynamic> json) => MUser(
      id: json['id'] as String,
      name: json['name'] as String?,
      avatar:
          (json['avatar'] as List<dynamic>?)?.map((e) => e as String).toList(),
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      dateOfBirth: json['dateOfBirth'] == null
          ? null
          : DateTime.parse(json['dateOfBirth'] as String),
      role: $enumDecodeNullable(_$AccountRoleEnumMap, json['role']),
      gender: $enumDecodeNullable(_$GenderEnumMap, json['gender']),
    );

Map<String, dynamic> _$MUserToJson(MUser instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'avatar': instance.avatar,
      'email': instance.email,
      'dateOfBirth': instance.dateOfBirth?.toIso8601String(),
      'gender': _$GenderEnumMap[instance.gender],
      'phone': instance.phone,
      'role': _$AccountRoleEnumMap[instance.role],
    };

const _$AccountRoleEnumMap = {
  AccountRole.user: 'user',
  AccountRole.admin: 'admin',
};

const _$GenderEnumMap = {
  Gender.male: 'male',
  Gender.female: 'female',
};
