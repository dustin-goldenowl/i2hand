import 'package:equatable/equatable.dart';
import 'package:i2hand/src/network/model/category/category.dart';

class AddProductState with EquatableMixin {
  AddProductState({required this.selectedCategory});

  final MCategory selectedCategory;

  AddProductState copyWith(
      {List<MCategory>? listCategories, MCategory? selectedCategory}) {
    return AddProductState(
        selectedCategory: selectedCategory ?? this.selectedCategory);
  }

  @override
  List<Object?> get props => [selectedCategory];
}
