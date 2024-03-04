import 'package:i2hand/src/feature/home/feature/search/logic/search_state.dart';
import 'package:i2hand/src/network/model/category/category.dart';
import 'package:i2hand/src/utils/base_cubit.dart';
class SearchBloc extends BaseCubit<SearchState> {
  SearchBloc()
      : super(SearchState(selectedCategories: List.empty(growable: true)));

  void onChangedSearchText(String text) {
    emit(state.copyWith(searchText: text));
  }

  void onChangedFilterCategories(MCategory category) {
    final listCategories = state.selectedCategories;
    List<MCategory> newList = listCategories.take(100).toList();
    for (MCategory cate in state.selectedCategories) {
      if (category == cate) {
        newList.remove(category);
        emit(state.copyWith(selectedCategories: newList));
        return;
      }
    }
    newList.add(category);
    emit(state.copyWith(selectedCategories: newList));
    return;
  }

  bool isSelectedCategory(MCategory category) {
    for (MCategory cate in state.selectedCategories) {
      if (category == cate) {
        return true;
      }
    }
    return false;
  }

  void onChangedLocation(String location) {
    emit(state.copyWith(
      location: location,
    ));
  }
}
