import 'dart:async';

import 'package:get_it/get_it.dart';
import 'package:i2hand/src/feature/home/logic/home_state.dart';
import 'package:i2hand/src/local/entities/most_viewed_products_entity.dart';
import 'package:i2hand/src/local/entities/new_products_entity.dart';
import 'package:i2hand/src/local/repo/most_viewed_product/most_viewed_product_local_repo.dart';
import 'package:i2hand/src/local/repo/new_product/new_product_local_repo.dart';
import 'package:i2hand/src/utils/base_cubit.dart';
import 'package:i2hand/src/utils/utils.dart';

class HomeBloc extends BaseCubit<HomeState> {
  HomeBloc() : super(HomeState(listCategory: List.empty(growable: true)));

  StreamSubscription? _newestProductsStream;

  Future<void> initial() async {
    await _getListMostViewedProducts();
    _initStream();
  }

  @override
  Future<void> close() {
    _newestProductsStream?.cancel();
    return super.close();
  }

  void _initStream() {
    _newestProductsStream = GetIt.I
        .get<NewProductsLocalRepo>()
        .getAllDetails()
        .watch()
        .listen((listNewProducts) {
      emit(state.copyWith(
        listNewProducts: listNewProducts.convertToProductData(),
      ));
    });
  }

  Future<void> _getListMostViewedProducts() async {
    try {
      final listMostViewedProducts = await GetIt.I
          .get<MostViewedProductsLocalRepo>()
          .getAllDetails()
          .get();
      if (isNullOrEmpty(listMostViewedProducts)) return;
      emit(state.copyWith(
        listMostViewedProduct: listMostViewedProducts.convertToProductData(),
      ));
    } catch (e) {
      xLog.e(e);
    }
  }
}
