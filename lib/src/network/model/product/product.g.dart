// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MProduct _$MProductFromJson(Map<String, dynamic> json) => MProduct(
      id: json['id'] as String,
      title: json['title'] as String? ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      province: json['province'] as String? ?? '',
      image:
          (json['image'] as List<dynamic>?)?.map((e) => e as String).toList(),
      isNew: json['isNew'] as bool? ?? false,
      viewed: json['viewed'] as int? ?? 0,
    );

Map<String, dynamic> _$MProductToJson(MProduct instance) => <String, dynamic>{
      'title': instance.title,
      'id': instance.id,
      'price': instance.price,
      'province': instance.province,
      'image': instance.image,
      'isNew': instance.isNew,
      'viewed': instance.viewed,
    };
