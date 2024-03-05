// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attribute.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MAttributeData<T> _$MAttributeDataFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    MAttributeData<T>(
      attributeName: $enumDecode(_$AttributeEnumEnumMap, json['attributeName']),
      data: fromJsonT(json['data']),
    );

Map<String, dynamic> _$MAttributeDataToJson<T>(
  MAttributeData<T> instance,
  Object? Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'attributeName': _$AttributeEnumEnumMap[instance.attributeName]!,
      'data': toJsonT(instance.data),
    };

const _$AttributeEnumEnumMap = {
  AttributeEnum.status: 'status',
  AttributeEnum.images: 'images',
  AttributeEnum.videos: 'videos',
  AttributeEnum.agency: 'agency',
  AttributeEnum.microProcessor: 'microProcessor',
  AttributeEnum.ram: 'ram',
  AttributeEnum.hardWare: 'hardWare',
  AttributeEnum.phoneLine: 'phoneLine',
  AttributeEnum.hardWareType: 'hardWareType',
  AttributeEnum.graphicsCard: 'graphicsCard',
  AttributeEnum.screenSize: 'screenSize',
  AttributeEnum.warrantyPolicy: 'warrantyPolicy',
  AttributeEnum.origin: 'origin',
  AttributeEnum.price: 'price',
};
