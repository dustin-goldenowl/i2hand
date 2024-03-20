import 'package:equatable/equatable.dart';
import 'package:i2hand/src/network/model/product/product.dart';

enum WishlistStatus { init, loading, fail, success }

class WishlistState with EquatableMixin {
  WishlistState({required this.wishlistProducts});

  final List<MProduct> wishlistProducts;

  WishlistState copyWith({List<MProduct>? wishlistProducts}) {
    return WishlistState(
        wishlistProducts: wishlistProducts ?? this.wishlistProducts);
  }

  @override
  List<Object?> get props => [wishlistProducts];

  @override
  String toString() {
    return 'WishlistState{wishlistProducts=$wishlistProducts}';
  }
}
