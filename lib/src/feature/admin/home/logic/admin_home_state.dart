import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:i2hand/src/config/enum/attribute.dart';
import 'package:i2hand/src/network/model/attribute/attribute.dart';
import 'package:i2hand/src/network/model/category/category.dart';

enum AdminHomeStatus { init, loading, success, fail }

class AdminHomeState {
  AdminHomeState({
    this.status = AdminHomeStatus.init,
    required this.listAttributes,
    required this.listCategories,
    this.name = '',
    required this.listAllAttributes,
    this.categoryImage,
    this.nameError,
    this.isImageError,
  });

  final AdminHomeStatus status;
  final List<MAttribute> listAttributes;
  final List<MCategory> listCategories;
  final List<DropdownMenuItem<AttributeEnum>> listAllAttributes;
  final String name;
  final String? nameError;
  final Uint8List? categoryImage;
  final bool? isImageError;

  AdminHomeState copyWith(
      {AdminHomeStatus? status,
      List<MAttribute>? listAttributes,
      List<DropdownMenuItem<AttributeEnum>>? listAllAttributes,
      String? name,
      String? nameError,
      Uint8List? categoryImage,
      bool? isImageError,
      List<MCategory>? listCategories}) {
    return AdminHomeState(
      status: status ?? this.status,
      name: name ?? this.name,
      listCategories: listCategories ?? this.listCategories,
      listAttributes: listAttributes ?? this.listAttributes,
      listAllAttributes: listAllAttributes ?? this.listAllAttributes,
      categoryImage: categoryImage ?? this.categoryImage,
      nameError: nameError ?? this.nameError,
      isImageError: isImageError ?? this.isImageError,
    );
  }
}
