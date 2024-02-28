import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:i2hand/src/feature/home/logic/home_state.dart';
import 'package:i2hand/src/network/data/category/category_repository.dart';
import 'package:i2hand/src/network/model/category/category.dart';
import 'package:i2hand/src/utils/utils.dart';

class HomeBloc extends Cubit<HomeState> {
  HomeBloc() : super(HomeState(listCategory: List.empty(growable: true)));

  void initial() {
    _getListCategories();
  }

  Future<void> _getListCategories() async {
    try {
      final result = await GetIt.I.get<CategoryRepository>().getCategories();
      List<MCategory> data = [];
      if (!isNullOrEmpty(result.data)) {
        for (MCategory category in result.data!) {
          final image = await GetIt.I
              .get<CategoryRepository>()
              .getImage(category.name.toLowerCase());
          if (isNullOrEmpty(image.data)) continue;
          data.add(
            category.copyWith(
              image: image.data!.toList().map((e) => e.toString()).toList(),
            ),
          );
        }
      }
      emit(state.copyWith(listCategory: data));
    } catch (e) {
      xLog.e(e);
    }
  }

  int getNumberColumns() {
    return state.listCategory.length ~/ 2 +
        state.listCategory.length.remainder(2);
  }

  bool checkInvalidIndex(int index) {
    return (2 * index + 1) >= state.listCategory.length;
  }
}
