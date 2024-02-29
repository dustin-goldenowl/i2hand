import 'package:i2hand/src/network/model/category/category.dart';
import 'package:i2hand/src/network/model/product/product.dart';

enum HomeStatus { init, loading, success, fail }

class HomeState {
  HomeState({
    required this.listCategory,
    this.listNewProducts,
    this.status = HomeStatus.init,
  });

  final List<MCategory> listCategory;
  final List<MProduct>? listNewProducts;
  final HomeStatus status;
  HomeState copyWith({
    List<MCategory>? listCategory,
    HomeStatus? status,
    List<MProduct>? listNewProducts,
  }) {
    return HomeState(
      listCategory: listCategory ?? this.listCategory,
      status: status ?? this.status,
      listNewProducts: listNewProducts ?? this.listNewProducts,
    );
  }
}
