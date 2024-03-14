import 'package:equatable/equatable.dart';
import 'package:i2hand/src/network/model/attribute/attribute_model.dart';
import 'package:i2hand/src/network/model/category/category.dart';

class GlobalState with EquatableMixin {
  GlobalState({
    required this.listCategories,
    required this.listAttributeData,
    this.isVerified = false,
  });

  final List<MCategory> listCategories;
  final List<MAttribute> listAttributeData;
  final bool isVerified;

  GlobalState copyWith({
    List<MCategory>? listCategories,
    List<MAttribute>? listAttributeData,
    bool? isVerified,
  }) {
    return GlobalState(
      listCategories: listCategories ?? this.listCategories,
      listAttributeData: listAttributeData ?? this.listAttributeData,
      isVerified: isVerified ?? this.isVerified,
    );
  }

  @override
  List<Object?> get props => [
        listCategories,
        listAttributeData,
        isVerified,
      ];
}
