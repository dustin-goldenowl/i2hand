// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MCategory _$MCategoryFromJson(Map<String, dynamic> json) => MCategory(
      name: json['name'] as String,
      attributes: (json['attributes'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      image:
          (json['image'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$MCategoryToJson(MCategory instance) => <String, dynamic>{
      'name': instance.name,
      'image': instance.image,
      'attributes': instance.attributes,
    };
