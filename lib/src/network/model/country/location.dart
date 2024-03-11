import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';

part 'location.g.dart';

@JsonSerializable(explicitToJson: true)
class MLocation with EquatableMixin {
  final String name;
  final String? iso2;
  final int id;

  MLocation({required this.name, this.iso2, required this.id});

  factory MLocation.empty() => MLocation(name: '', id: 0);

  MLocation copyWith({String? name, String? iso2, int? id}) {
    return MLocation(
        name: name ?? this.name, iso2: iso2 ?? this.iso2, id: id ?? this.id);
  }

  @override
  List<Object?> get props => [name, iso2, id];

  @override
  String toString() {
    return 'MLocation{name=$name, iso2=$iso2, id=$id}';
  }

  Map<String, dynamic> toJson() => _$MLocationToJson(this);

  factory MLocation.fromJson(Map<String, dynamic> json) =>
      _$MLocationFromJson(json);
}
