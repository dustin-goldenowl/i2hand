// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recently_viewed.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MRecentlyViewedProduct _$MRecentlyViewedProductFromJson(
        Map<String, dynamic> json) =>
    MRecentlyViewedProduct(
      id: json['id'] as String,
      image: (json['image'] as List<dynamic>).map((e) => e as String).toList(),
      time: json['time'] as int,
    );

Map<String, dynamic> _$MRecentlyViewedProductToJson(
        MRecentlyViewedProduct instance) =>
    <String, dynamic>{
      'id': instance.id,
      'image': instance.image,
      'time': instance.time,
    };
