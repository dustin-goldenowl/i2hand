// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attribute_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MAttribute _$MAttributeFromJson(Map<String, dynamic> json) => MAttribute(
      name: $enumDecode(_$AttributeEnumEnumMap, json['name']),
      isRequired: json['isRequired'] as bool? ?? false,
      data: (json['data'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$MAttributeToJson(MAttribute instance) =>
    <String, dynamic>{
      'name': _$AttributeEnumEnumMap[instance.name]!,
      'isRequired': instance.isRequired,
      'data': instance.data,
    };

const _$AttributeEnumEnumMap = {
  AttributeEnum.status: 'status',
  AttributeEnum.images: 'images',
  AttributeEnum.videos: 'videos',
  AttributeEnum.agencyPhone: 'agencyPhone',
  AttributeEnum.agencyLaptop: 'agencyLaptop',
  AttributeEnum.microProcessor: 'microProcessor',
  AttributeEnum.ram: 'ram',
  AttributeEnum.hardWare: 'hardWare',
  AttributeEnum.phoneLine: 'phoneLine',
  AttributeEnum.hardWareType: 'hardWareType',
  AttributeEnum.graphicsCard: 'graphicsCard',
  AttributeEnum.screenSize: 'screenSize',
  AttributeEnum.warrantyPolicy: 'warrantyPolicy',
  AttributeEnum.origin: 'origin',
  AttributeEnum.color: 'color',
  AttributeEnum.price: 'price',
};
