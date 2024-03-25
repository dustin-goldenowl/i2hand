// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MOrder _$MOrderFromJson(Map<String, dynamic> json) => MOrder(
      id: json['id'] as String,
      productId: json['productId'] as String,
      createdOrderTime: json['createdOrderTime'] as int,
    );

Map<String, dynamic> _$MOrderToJson(MOrder instance) => <String, dynamic>{
      'id': instance.id,
      'productId': instance.productId,
      'createdOrderTime': instance.createdOrderTime,
    };
