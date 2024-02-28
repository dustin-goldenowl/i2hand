import 'package:equatable/equatable.dart';
import 'package:i2hand/src/config/enum/attribute.dart';

class MAttribute with EquatableMixin {
  MAttribute({required this.attribute, this.isRequired = false});

  final AttributeEnum attribute;
  final bool isRequired;

  MAttribute copyWith({
    AttributeEnum? attribute,
    bool? isRequired,
  }) {
    return MAttribute(
        attribute: attribute ?? this.attribute,
        isRequired: isRequired ?? this.isRequired);
  }

  @override
  String toString() {
    return 'XAttribute{attribute=$attribute, isRequired=$isRequired}';
  }

  @override
  List<Object?> get props => [attribute, isRequired];
}
