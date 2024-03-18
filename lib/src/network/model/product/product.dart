import 'package:i2hand/src/local/database_app.dart';
import 'package:i2hand/src/network/model/product/attribute/attribute.dart';
import 'package:i2hand/src/utils/string_ext.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';

part 'product.g.dart';

@JsonSerializable()
class MProduct with EquatableMixin {
  final String title;
  final String id;
  final double price;
  final String province;
  final List<String>? image;
  final bool isNew;
  final int viewed;
  final List<MAttributeData>? attributes;
  final DateTime? time;
  final String description;
  final String owner;

  MProduct({
    required this.id,
    this.title = '',
    this.time,
    this.description = '',
    this.attributes,
    this.price = 0.0,
    this.province = '',
    this.image,
    this.isNew = false,
    this.viewed = 0,
    this.owner = '',
  });

  factory MProduct.empty() => MProduct(id: '');
  MProduct copyWith({
    String? title,
    String? id,
    double? price,
    String? province,
    bool? isNew,
    int? viewed,
    List<String>? image,
    List<MAttributeData>? attributes,
    DateTime? time,
    String? description,
    String? owner,
  }) {
    return MProduct(
      title: title ?? this.title,
      id: id ?? this.id,
      price: price ?? this.price,
      province: province ?? this.province,
      image: image ?? this.image,
      isNew: isNew ?? this.isNew,
      viewed: viewed ?? this.viewed,
      attributes: attributes ?? this.attributes,
      time: time ?? this.time,
      description: description ?? this.description,
      owner: owner ?? this.owner,
    );
  }

  @override
  List<Object?> get props => [
        title,
        id,
        price,
        province,
        image,
        viewed,
        isNew,
        attributes,
        time,
        description,
        owner,
      ];

  @override
  String toString() {
    return 'MProduct{title=$title, id=$id, price=$price, province=$province, image=$image, isNew=$isNew, viewed=$viewed, attributes=$attributes, time=$time, description=$description}';
  }

  Map<String, dynamic> toJson() => _$MProductToJson(this);

  factory MProduct.fromJson(Map<String, dynamic> json) =>
      _$MProductFromJson(json);
}

extension MProductExt on MProduct {
  NewProductsEntityData convertToNewProductLocalData() {
    final jsonData = toJson();
    jsonData['image'] = (image ?? []).convertToUint8List();
    return NewProductsEntityData.fromJson(jsonData);
  }

  MostViewProductsEntityData convertToMostViewedProductLocalData() {
    final jsonData = toJson();
    jsonData['image'] = (image ?? []).convertToUint8List();
    return MostViewProductsEntityData.fromJson(jsonData);
  }

  ProductsEntityData convertToProductLocalData() {
    final jsonData = toJson();
    jsonData['image'] = (image ?? []).convertToUint8List();
    return ProductsEntityData.fromJson(jsonData);
  }
}
