import 'package:i2hand/src/network/model/category/category.dart';

enum HomeStatus { init, loading, success, fail }

class HomeState {
  HomeState({
    required this.listCategory,
    this.status = HomeStatus.init,
  });

  final List<MCategory> listCategory;
  final HomeStatus status;
  HomeState copyWith({List<MCategory>? listCategory, HomeStatus? status}) {
    return HomeState(
        listCategory: listCategory ?? this.listCategory,
        status: status ?? this.status);
  }
}
