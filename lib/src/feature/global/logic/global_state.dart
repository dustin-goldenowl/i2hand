import 'package:equatable/equatable.dart';
import 'package:i2hand/src/network/model/category/category.dart';

class GlobalState with EquatableMixin {
  GlobalState({required this.listCategories});

  final List<MCategory> listCategories;

  GlobalState copyWith({List<MCategory>? listCategories}) {
    return GlobalState(listCategories: listCategories ?? this.listCategories);
  }

  @override
  List<Object?> get props => [listCategories];
}
