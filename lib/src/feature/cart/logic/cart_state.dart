import 'package:equatable/equatable.dart';
import 'package:i2hand/src/network/model/product/product.dart';

enum CartStatus { init, loading, fail, success }

class CartState with EquatableMixin {
  CartState({
    this.status = CartStatus.init,
    required this.listProductsInCart,
    required this.listProductsInWishlist,
    required this.listPopularProduct,
    this.shippingAddress = ' ',
  });

  final CartStatus status;
  final List<MProduct> listProductsInCart;
  final List<MProduct> listProductsInWishlist;
  final List<MProduct> listPopularProduct;
  final String shippingAddress;

  CartState copyWith({
    CartStatus? status,
    List<MProduct>? listProductsInCart,
    List<MProduct>? listProductsInWishlist,
    List<MProduct>? listPopularProduct,
    String? shippingAddress,
  }) {
    return CartState(
      status: status ?? this.status,
      listProductsInCart: listProductsInCart ?? this.listProductsInCart,
      listProductsInWishlist:
          listProductsInWishlist ?? this.listProductsInWishlist,
      listPopularProduct: listPopularProduct ?? this.listPopularProduct,
      shippingAddress: shippingAddress ?? this.shippingAddress,
    );
  }

  @override
  List<Object?> get props => [
        status,
        listProductsInCart,
        listProductsInWishlist,
        listPopularProduct,
        shippingAddress
      ];

  @override
  String toString() {
    return 'CartState{status=$status, listProductsInCart=$listProductsInCart, listProductsInWishlist=$listProductsInWishlist}';
  }
}
