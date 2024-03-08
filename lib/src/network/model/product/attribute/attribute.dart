import 'package:json_annotation/json_annotation.dart';
import 'package:flutter/material.dart';
import 'package:i2hand/src/config/enum/attribute_enum.dart';
import 'package:equatable/equatable.dart';

part 'attribute.g.dart';

@JsonSerializable(genericArgumentFactories: true, explicitToJson: true)
class MAttributeData<T> with EquatableMixin {
  @JsonKey(name: 'attributeName')
  final AttributeEnum attributeName;
  @JsonKey(name: 'data')
  final T data;

  MAttributeData({required this.attributeName, required this.data});

  MAttributeData copyWith(
      {AttributeEnum? attributeName, ValueGetter<T?>? data}) {
    return MAttributeData(
        attributeName: attributeName ?? this.attributeName,
        data: data != null ? data() : this.data);
  }

  @override
  List<Object?> get props => [attributeName, data];

  @override
  String toString() {
    return 'MAttribute{attributeName=$attributeName, data=$data}';
  }

  Map<String, dynamic> toJson(Object Function(T) toJsonT) =>
      _$MAttributeDataToJson(this, toJsonT);

  factory MAttributeData.fromJson(
          Map<String, dynamic> json, T Function(Object? json) fromJsonT) =>
      _$MAttributeDataFromJson<T>(json, fromJsonT);
}
