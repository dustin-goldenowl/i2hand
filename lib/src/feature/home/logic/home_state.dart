import 'package:i2hand/src/network/model/category/category.dart';
import 'package:i2hand/src/network/model/product/product.dart';

enum HomeStatus { init, loading, success, fail }

class HomeState {
  HomeState({
    required this.listCategory,
    this.listNewProducts,
    this.status = HomeStatus.init,
    this.listMostViewedProduct,
  });

  final List<MCategory> listCategory;
  final List<MProduct>? listNewProducts;
  final List<MProduct>? listMostViewedProduct;
  final HomeStatus status;
  HomeState copyWith({
    List<MCategory>? listCategory,
    HomeStatus? status,
    List<MProduct>? listNewProducts,
    List<MProduct>? listMostViewedProduct,
  }) {
    return HomeState(
      listCategory: listCategory ?? this.listCategory,
      status: status ?? this.status,
      listNewProducts: listNewProducts ?? this.listNewProducts,
      listMostViewedProduct:
          listMostViewedProduct ?? this.listMostViewedProduct,
    );
  }
}
