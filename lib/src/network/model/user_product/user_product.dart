import 'package:i2hand/src/local/database_app.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';
import 'package:i2hand/src/config/constants/app_const.dart';
import 'package:i2hand/src/utils/string_utils.dart';

part 'user_product.g.dart';

@JsonSerializable()
class MUserProduct with EquatableMixin {
  final String id;

  MUserProduct({required this.id});

  factory MUserProduct.empty() => MUserProduct(
      id: StringUtils.createGenerateRandomText(
          length: AppConstantData.userIdGenerateRandom));
  MUserProduct copyWith({String? id}) {
    return MUserProduct(id: id ?? this.id);
  }

  @override
  List<Object?> get props => [id];

  @override
  String toString() {
    return 'MUserProduct{id=$id}';
  }

  Map<String, dynamic> toJson() => _$MUserProductToJson(this);

  factory MUserProduct.fromJson(Map<String, dynamic> json) =>
      _$MUserProductFromJson(json);
}

extension MUserProductExt on MUserProduct {
  WishlistProductsEntityData convertToWishlistProductLocalData() {
    final jsonData = toJson();
    return WishlistProductsEntityData.fromJson(jsonData);
  }
}
