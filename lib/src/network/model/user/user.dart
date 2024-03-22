import 'package:equatable/equatable.dart';
import 'package:i2hand/src/config/constants/app_const.dart';
import 'package:i2hand/src/config/enum/account.dart';
import 'package:i2hand/src/utils/string_utils.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:i2hand/src/config/enum/gender.dart';

part 'user.g.dart';

@JsonSerializable()
class MUser with EquatableMixin {
  final String id;
  final String? name;
  final List<String>? avatar;
  final String? email;
  final DateTime? dateOfBirth;
  final Gender? gender;
  final String? phone;
  final AccountRole? role;
  final bool eKYC;
  final String? address;

  MUser(
      {required this.id,
      this.name,
      this.avatar,
      this.email,
      this.phone,
      this.dateOfBirth,
      this.role,
      this.eKYC = false,
      this.address,
      this.gender});

  factory MUser.empty() => MUser(
      id: StringUtils.createGenerateRandomText(
          length: AppConstantData.userIdGenerateRandom));

  @override
  String toString() {
    return 'MUser{id=$id, name=$name, avatar=$avatar, email=$email, dateOfBirth=$dateOfBirth, gender=$gender, phone=$phone, role=$role, eKYC=$eKYC, address=$address}';
  }

  Map<String, dynamic> toJson() => _$MUserToJson(this);

  factory MUser.fromJson(Map<String, dynamic> json) => _$MUserFromJson(json);

  @override
  List<Object?> get props => [
        id,
        name,
        avatar,
        email,
        dateOfBirth,
        gender,
        phone,
        role,
        eKYC,
        address
      ];
  MUser copyWith(
      {String? id,
      String? name,
      List<String>? avatar,
      String? email,
      String? phone,
      AccountRole? role,
      DateTime? dateOfBirth,
      bool? eKYC,
      String? address,
      Gender? gender}) {
    return MUser(
      id: id ?? this.id,
      name: name ?? this.name,
      avatar: avatar ?? this.avatar,
      email: email ?? this.email,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      phone: phone ?? this.phone,
      role: role ?? this.role,
      eKYC: eKYC ?? this.eKYC,
      gender: gender ?? this.gender,
      address: address ?? this.address,
    );
  }
}
