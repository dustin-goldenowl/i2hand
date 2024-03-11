import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';
import 'package:i2hand/src/config/enum/attribute_enum.dart';

part 'attribute_model.g.dart';

@JsonSerializable()
class MAttribute with EquatableMixin {
  MAttribute({
    required this.name,
    this.isRequired = false,
    this.data,
  });

  final AttributeEnum name;
  final bool isRequired;
  final List<String>? data;

  MAttribute copyWith(
      {AttributeEnum? name, bool? isRequired, List<String>? data}) {
    return MAttribute(
        name: name ?? this.name,
        isRequired: isRequired ?? this.isRequired,
        data: data ?? this.data);
  }

  factory MAttribute.empty() => MAttribute(name: AttributeEnum.status);

  @override
  String toString() {
    return 'MAttribute{name=$name, isRequired=$isRequired, data=$data}';
  }

  @override
  List<Object?> get props => [name, isRequired, data];

  Map<String, dynamic> toJson() => _$MAttributeToJson(this);

  factory MAttribute.fromJson(Map<String, dynamic> json) =>
      _$MAttributeFromJson(json);
}
