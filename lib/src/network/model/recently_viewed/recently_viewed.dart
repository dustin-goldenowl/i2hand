import 'package:i2hand/src/utils/string_ext.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:i2hand/src/local/database_app.dart';
import 'package:equatable/equatable.dart';
import 'package:i2hand/src/config/constants/app_const.dart';
import 'package:i2hand/src/utils/string_utils.dart';

part 'recently_viewed.g.dart';

@JsonSerializable()
class MRecentlyViewedProduct with EquatableMixin {
  final String id;
  final List<String> image;
  final int time;

  MRecentlyViewedProduct({
    required this.id,
    required this.image,
    required this.time,
  });

  factory MRecentlyViewedProduct.empty() => MRecentlyViewedProduct(
        id: StringUtils.createGenerateRandomText(
            length: AppConstantData.userIdGenerateRandom),
        image: List.empty(),
        time: 0,
      );
  MRecentlyViewedProduct copyWith({String? id, List<String>? image, int? time}) {
    return MRecentlyViewedProduct(
      id: id ?? this.id,
      image: image ?? this.image,
      time: time ?? this.time,
    );
  }

  @override
  List<Object?> get props => [id, image, time];

  @override
  String toString() {
    return 'MRecentlyViewedProduct{id=$id, image=$image}';
  }

  Map<String, dynamic> toJson() => _$MRecentlyViewedProductToJson(this);

  factory MRecentlyViewedProduct.fromJson(Map<String, dynamic> json) =>
      _$MRecentlyViewedProductFromJson(json);
}

extension MRecentlyViewedProductExt on MRecentlyViewedProduct {
  RecentlyViewedEntityData convertToWishlistProductLocalData() {
    final jsonData = toJson();
    jsonData['image'] = image.convertToUint8List();
    return RecentlyViewedEntityData.fromJson(jsonData);
  }
}
