import 'package:get_it/get_it.dart';
import 'package:i2hand/src/feature/global/logic/global_state.dart';
import 'package:i2hand/src/network/data/attribute/attribute_repository.dart';
import 'package:i2hand/src/network/data/category/category_repository.dart';
import 'package:i2hand/src/network/model/category/category.dart';
import 'package:i2hand/src/utils/base_cubit.dart';
import 'package:i2hand/src/utils/utils.dart';

class GlobalBloc extends BaseCubit<GlobalState> {
  GlobalBloc()
      : super(GlobalState(
          listCategories: List.empty(growable: true),
          listAttributeData: List.empty(growable: true),
        ));

  Future<void> getListCategories() async {
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
      emit(state.copyWith(listCategories: data));
    } catch (e) {
      xLog.e(e);
    }
  }

  void updateListCategories(List<MCategory> listCategories) {
    emit(state.copyWith(listCategories: listCategories));
  }

  int getNumberColumns() {
    return state.listCategories.length ~/ 2 +
        state.listCategories.length.remainder(2);
  }

  bool checkInvalidIndex(int index) {
    return (2 * index + 1) >= state.listCategories.length;
  }

  Future<void> getListAttributes() async {
    try {
      final result = await GetIt.I.get<AttributeRepository>().getAttributes();
      if (!isNullOrEmpty(result.data)) {
        emit(state.copyWith(listAttributeData: result.data!));
      }
    } catch (e) {
      xLog.e(e);
    }
  }
}
