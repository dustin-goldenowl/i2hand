import 'package:equatable/equatable.dart';
import 'package:i2hand/src/network/model/attribute/attribute_model.dart';
import 'package:i2hand/src/network/model/category/category.dart';

class GlobalState with EquatableMixin {
  GlobalState({
    required this.listCategories,
    required this.listAttributeData,
  });

  final List<MCategory> listCategories;
  final List<MAttribute> listAttributeData;

  GlobalState copyWith({
    List<MCategory>? listCategories,
    List<MAttribute>? listAttributeData,
  }) {
    return GlobalState(
      listCategories: listCategories ?? this.listCategories,
      listAttributeData: listAttributeData ?? this.listAttributeData,
    );
  }

  @override
  List<Object?> get props => [
        listCategories,
        listAttributeData,
      ];
}
