// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MProduct _$MProductFromJson(Map<String, dynamic> json) => MProduct(
      id: json['id'] as String,
      title: json['title'] as String? ?? '',
      time:
          json['time'] == null ? null : DateTime.parse(json['time'] as String),
      description: json['description'] as String? ?? '',
      attributes: (json['attributes'] as List<dynamic>?)
          ?.map((e) => MAttributeData<dynamic>.fromJson(
              e as Map<String, dynamic>, (value) => value))
          .toList(),
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      province: json['province'] as String? ?? '',
      image:
          (json['image'] as List<dynamic>?)?.map((e) => e as String).toList(),
      isNew: json['isNew'] as bool? ?? false,
      viewed: json['viewed'] as int? ?? 0,
      owner: json['owner'] as String? ?? '',
    );

Map<String, dynamic> _$MProductToJson(MProduct instance) => <String, dynamic>{
      'title': instance.title,
      'id': instance.id,
      'price': instance.price,
      'province': instance.province,
      'image': instance.image,
      'isNew': instance.isNew,
      'viewed': instance.viewed,
      'attributes': instance.attributes
          ?.map((e) => e.toJson(
                (value) => value,
              ))
          .toList(),
      'time': instance.time?.toIso8601String(),
      'description': instance.description,
      'owner': instance.owner,
    };
