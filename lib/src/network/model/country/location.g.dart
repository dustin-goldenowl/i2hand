// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MLocation _$MLocationFromJson(Map<String, dynamic> json) => MLocation(
      name: json['name'] as String,
      iso2: json['iso2'] as String?,
      id: json['id'] as int,
    );

Map<String, dynamic> _$MLocationToJson(MLocation instance) => <String, dynamic>{
      'name': instance.name,
      'iso2': instance.iso2,
      'id': instance.id,
    };
