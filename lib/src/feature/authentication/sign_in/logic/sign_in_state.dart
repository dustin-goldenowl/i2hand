import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:i2hand/src/network/model/common/social_type.dart';
import 'package:i2hand/src/network/model/user/user.dart';

enum SignInStatus { init, signingIn, failed, successed }

class SignInState with EquatableMixin {
  SignInState({
    this.status = SignInStatus.init,
    this.email,
    this.emailValidated,
    this.password,
    this.loginType,
    this.isWrongPassword,
    this.user,
    this.isShowForgotPass,
    this.avatar,
  });

  final String? email;
  final String? emailValidated;
  final String? password;
  final bool? isWrongPassword;
  final bool? isShowForgotPass;
  final SignInStatus status;
  final MSocialType? loginType;
  final MUser? user;
  final Uint8List? avatar;

  @override
  List<Object?> get props => [
        email,
        emailValidated,
        password,
        isWrongPassword,
        status,
        loginType,
        user,
        isShowForgotPass,
        avatar,
      ];

  SignInState copyWith({
    String? email,
    String? emailValidated,
    String? password,
    MSocialType? loginType,
    bool? isWrongPassword,
    SignInStatus? status,
    MUser? user,
    bool? isShowForgotPass,
    Uint8List? avatar,
  }) {
    return SignInState(
      email: email ?? this.email,
      emailValidated: emailValidated ?? this.emailValidated,
      password: password ?? this.password,
      isWrongPassword: isWrongPassword ?? this.isWrongPassword,
      loginType: loginType ?? this.loginType,
      status: status ?? this.status,
      user: user ?? this.user,
      isShowForgotPass: isShowForgotPass ?? this.isShowForgotPass,
      avatar: avatar ?? this.avatar,
    );
  }
}
