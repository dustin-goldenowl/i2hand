import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:i2hand/src/network/model/category/category.dart';

enum AddProductStatus { init, loading, success, fail }

class AddProductState with EquatableMixin {
  AddProductState({
    required this.selectedCategory,
    required this.attributesData,
    this.title = '',
    this.address = '',
    this.description = '',
    this.listImage,
    this.videoThumbnail,
    this.status = AddProductStatus.init,
  });

  final AddProductStatus status;
  final MCategory selectedCategory;
  final Map<String, String> attributesData;
  final String title;
  final String description;
  final String address;
  final List<Uint8List>? listImage;
  final Uint8List? videoThumbnail;

  AddProductState copyWith({
    MCategory? selectedCategory,
    Map<String, String>? attributesData,
    String? title,
    String? description,
    String? address,
    List<Uint8List>? listImage,
    Uint8List? videoThumbnail,
    AddProductStatus? status,
  }) {
    return AddProductState(
      selectedCategory: selectedCategory ?? this.selectedCategory,
      attributesData: attributesData ?? this.attributesData,
      title: title ?? this.title,
      description: description ?? this.description,
      address: address ?? this.address,
      listImage: listImage ?? this.listImage,
      videoThumbnail: videoThumbnail ?? this.videoThumbnail,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [
        selectedCategory,
        attributesData,
        title,
        description,
        address,
        listImage,
        videoThumbnail,
        status,
      ];

  Map<String, String> get getAttributesData {
    final rawData = attributesData;
    return rawData.map((key, value) => MapEntry(key, value));
  }
}
