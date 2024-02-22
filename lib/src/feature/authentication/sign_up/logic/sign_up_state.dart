import 'dart:typed_data';

import 'package:equatable/equatable.dart';
import 'package:i2hand/src/network/model/common/social_type.dart';
import 'package:i2hand/src/network/model/country/country_code.dart';

enum SignUpStatus { init, signingIn, failed, successed }

class SignUpState with EquatableMixin {
  SignUpState({
    this.status = SignUpStatus.init,
    this.email = '',
    this.emailValidated,
    this.name = '',
    this.nameValidated,
    this.phone = '',
    this.phoneValidated,
    this.password = '',
    this.confirmPassword = '',
    this.loginType,
    this.isWrongPassword,
    this.country,
    this.avatar,
  });

  final String email;
  final String? emailValidated;
  final String name;
  final String? nameValidated;
  final String phone;
  final String? phoneValidated;
  final String password;
  final String confirmPassword;
  final bool? isWrongPassword;
  final SignUpStatus status;
  final MSocialType? loginType;
  final CountryCode? country;
  final Uint8List? avatar;

  @override
  List<Object?> get props => [
        email,
        emailValidated,
        password,
        isWrongPassword,
        status,
        loginType,
        phone,
        phoneValidated,
        confirmPassword,
        name,
        nameValidated,
        country,
        avatar,
      ];

  SignUpState copyWith({
    String? email,
    String? name,
    String? nameValidated,
    String? emailValidated,
    String? phone,
    String? phoneValidated,
    String? password,
    String? confirmPassword,
    MSocialType? loginType,
    bool? isWrongPassword,
    SignUpStatus? status,
    CountryCode? country,
    Uint8List? avatar,
  }) {
    return SignUpState(
      email: email ?? this.email,
      emailValidated: emailValidated ?? this.emailValidated,
      name: name ?? this.name,
      nameValidated: nameValidated ?? this.nameValidated,
      password: password ?? this.password,
      isWrongPassword: isWrongPassword ?? this.isWrongPassword,
      loginType: loginType ?? this.loginType,
      status: status ?? this.status,
      phone: phone ?? this.phone,
      phoneValidated: phoneValidated ?? this.phoneValidated,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      country: country ?? this.country,
      avatar: avatar ?? this.avatar,
    );
  }
}
