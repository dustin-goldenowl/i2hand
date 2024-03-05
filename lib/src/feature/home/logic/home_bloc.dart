import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:i2hand/src/feature/home/logic/home_state.dart';
import 'package:i2hand/src/local/entities/new_products_entity.dart';
import 'package:i2hand/src/local/repo/new_product/new_product_local_repo.dart';
import 'package:i2hand/src/utils/utils.dart';

class HomeBloc extends Cubit<HomeState> {
  HomeBloc() : super(HomeState(listCategory: List.empty(growable: true)));

  Future<void> initial() async {
    await _getListNewProducts();
  }

  Future<void> _getListNewProducts() async {
    try {
      final listNewProducts =
          await GetIt.I.get<NewProductsLocalRepo>().getAllDetails().get();
      if (isNullOrEmpty(listNewProducts)) return;
      emit(state.copyWith(
        listNewProducts: listNewProducts.convertToProductData(),
      ));
    } catch (e) {
      xLog.e(e);
    }
  }
}
