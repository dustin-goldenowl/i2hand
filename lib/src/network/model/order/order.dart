import 'package:i2hand/src/config/enum/order_enum.dart';
import 'package:i2hand/src/local/database_app.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';
import 'package:i2hand/src/config/constants/app_const.dart';
import 'package:i2hand/src/utils/string_utils.dart';

part 'order.g.dart';

@JsonSerializable()
class MOrder with EquatableMixin {
  final String id;
  final String productId;
  final int createdOrderTime;
  final OrderStatusEnum status;

  MOrder({
    required this.id,
    required this.productId,
    required this.createdOrderTime,
    this.status = OrderStatusEnum.pending,
  });

  factory MOrder.empty() => MOrder(
        id: StringUtils.createGenerateRandomOrderNumber(
            length: AppConstantData.orderNumberLength),
        productId: '',
        createdOrderTime: 0,
      );
  MOrder copyWith({String? id, String? productId, int? createdOrderTime, OrderStatusEnum? status}) {
    return MOrder(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      createdOrderTime: createdOrderTime ?? this.createdOrderTime,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [id, productId, createdOrderTime, status];

  @override
  String toString() {
    return 'MOrder{id=$id, productId=$productId, createdOrderTime=$createdOrderTime, status=$status}';
  }

  Map<String, dynamic> toJson() => _$MOrderToJson(this);

  factory MOrder.fromJson(Map<String, dynamic> json) => _$MOrderFromJson(json);
}

extension MOrderExt on MOrder {
  WishlistProductsEntityData convertToWishlistProductLocalData() {
    final jsonData = toJson();
    return WishlistProductsEntityData.fromJson(jsonData);
  }
}
