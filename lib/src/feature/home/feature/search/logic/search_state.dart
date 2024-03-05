import 'package:equatable/equatable.dart';
import 'package:i2hand/src/network/model/category/category.dart';

enum SearchStatus { init, loading, fail, success }

class SearchState with EquatableMixin {
  SearchState(
      {this.status = SearchStatus.init,
      this.searchText = '',
      this.location = '',
      required this.selectedCategories});

  final SearchStatus status;
  final String searchText;
  final String location;
  final List<MCategory> selectedCategories;
  SearchState copyWith(
      {SearchStatus? status,
      String? searchText,
      String? location,
      List<MCategory>? selectedCategories}) {
    return SearchState(
        status: status ?? this.status,
        searchText: searchText ?? this.searchText,
        location: location ?? this.location,
        selectedCategories: selectedCategories ?? this.selectedCategories);
  }

  @override
  List<Object?> get props => [status, searchText, selectedCategories, location];

  @override
  String toString() {
    return 'SearchState{status=$status, searchText=$searchText, selectedCategories=$selectedCategories, location=$location}';
  }
}
