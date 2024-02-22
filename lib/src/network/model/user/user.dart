import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:i2hand/src/config/enum/gender.dart';

part 'user.g.dart';

@JsonSerializable()
class MUser with EquatableMixin {
  final String id;
  final String? name;
  final String? avatar;
  final String? email;
  final DateTime? dateOfBirth;
  final Gender? gender;
  final String? phone;

  MUser(
      {required this.id,
      this.name,
      this.avatar,
      this.email,
      this.phone,
      this.dateOfBirth,
      this.gender});

  @override
  String toString() {
    return 'MUser{id=$id, name=$name, avatar=$avatar, email=$email, dateOfBirth=$dateOfBirth, gender=$gender, phone=$phone}';
  }

  Map<String, dynamic> toJson() => _$MUserToJson(this);

  factory MUser.fromJson(Map<String, dynamic> json) => _$MUserFromJson(json);

  @override
  List<Object?> get props =>
      [id, name, avatar, email, dateOfBirth, gender, phone];
  MUser copyWith(
      {String? id,
      String? name,
      String? avatar,
      String? email,
      String? phone,
      DateTime? dateOfBirth,
      Gender? gender}) {
    return MUser(
        id: id ?? this.id,
        name: name ?? this.name,
        avatar: avatar ?? this.avatar,
        email: email ?? this.email,
        dateOfBirth: dateOfBirth ?? this.dateOfBirth,
        phone: phone ?? this.phone,
        gender: gender ?? this.gender);
  }
}
