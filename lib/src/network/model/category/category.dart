import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';

part 'category.g.dart';

@JsonSerializable()
class MCategory with EquatableMixin {
  final String name;
  final List<String>? image;
  final List<String> attributes;

  MCategory({required this.name, required this.attributes, this.image});

  factory MCategory.empty() => MCategory(name: '', attributes: []);
  MCategory copyWith(
      {String? name, List<String>? image, List<String>? attributes}) {
    return MCategory(
        name: name ?? this.name,
        image: image ?? this.image,
        attributes: attributes ?? this.attributes);
  }

  @override
  String toString() {
    return 'MCategory{name=$name, image=$image, categories=$attributes}';
  }

  Map<String, dynamic> toJson() => _$MCategoryToJson(this);

  factory MCategory.fromJson(Map<String, dynamic> json) =>
      _$MCategoryFromJson(json);

  @override
  List<Object?> get props => [name, image, attributes];
}
