import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'location.g.dart';

@JsonSerializable(explicitToJson: true)
class MLocation with EquatableMixin {
  final String name;

  MLocation({required this.name});

  MLocation copyWith({String? name}) {
    return MLocation(
        name: name ?? this.name);
  }

  @override
  List<Object?> get props => [name];

  @override
  String toString() {
    return 'MLocation{name=$name}';
  }

  Map<String, dynamic> toJson() => _$MLocationToJson(this);

  factory MLocation.fromJson(Map<String, dynamic> json) =>
      _$MLocationFromJson(json);
}
