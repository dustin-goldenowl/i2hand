// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MOrder _$MOrderFromJson(Map<String, dynamic> json) => MOrder(
      id: json['id'] as String,
      productId: json['productId'] as String,
      createdOrderTime: json['createdOrderTime'] as int,
      status: $enumDecodeNullable(_$OrderStatusEnumEnumMap, json['status']) ??
          OrderStatusEnum.pending,
    );

Map<String, dynamic> _$MOrderToJson(MOrder instance) => <String, dynamic>{
      'id': instance.id,
      'productId': instance.productId,
      'createdOrderTime': instance.createdOrderTime,
      'status': _$OrderStatusEnumEnumMap[instance.status]!,
    };

const _$OrderStatusEnumEnumMap = {
  OrderStatusEnum.none: 'none',
  OrderStatusEnum.pending: 'pending',
  OrderStatusEnum.succeeded: 'succeeded',
  OrderStatusEnum.failed: 'failed',
};
