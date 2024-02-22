import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:i2hand/package/dismiss_keyboard/dismiss_keyboard.dart';
import 'package:i2hand/src/config/constants/app_const.dart';
import 'package:i2hand/src/dialog/toast_wrapper.dart';
import 'package:i2hand/src/feature/authentication/sign_up/logic/sign_up_state.dart';
import 'package:i2hand/src/network/model/common/result.dart';
import 'package:i2hand/src/network/model/common/social_type.dart';
import 'package:i2hand/src/network/model/country/country_code.dart';
import 'package:i2hand/src/network/model/domain_manager.dart';
import 'package:i2hand/src/network/model/social_user/social_user.dart';
import 'package:i2hand/src/network/model/user/user.dart';
import 'package:i2hand/src/utils/string_utils.dart';
import 'package:i2hand/src/utils/utils.dart';
import 'package:i2hand/src/utils/validated.dart';

class SignUpBloc extends Cubit<SignUpState> {
  SignUpBloc() : super(SignUpState());

  DomainManager get domain => DomainManager();

  void emitSignInFailed() {
    emit(state.copyWith(status: SignUpStatus.failed));
  }

  Future signupWithEmail(BuildContext context) async {
    if (state.status == SignUpStatus.signingIn) return;
    if (!isValidatedInput(context)) {
      emit(state.copyWith(status: SignUpStatus.failed));
      return;
    }
    emit(state.copyWith(
      status: SignUpStatus.signingIn,
    ));
    final email = state.email;
    final password = state.password;
    final name = state.name;
    final phone = state.phone;
    try {
      final result = await domain.sign.signUpWithEmail(
          email: email, password: password, name: name, phone: phone);
      loginDecision(result, socialType: MSocialType.email);
    } catch (e) {
      xLog.e(e);
    }
  }

  Future signUpWithGoogle(BuildContext context) async {
    if (state.status == SignUpStatus.signingIn) return;
    emit(state.copyWith(
      status: SignUpStatus.signingIn,
      loginType: MSocialType.google,
    ));
    try {
      final result = await domain.sign.loginWithGoogle();
      return loginSocialDecision(result, MSocialType.google);
    } catch (e) {
      xLog.e(e);
    }
  }

  bool isValidatedInput(BuildContext context) {
    final emailError = AppValidator.emailValidated(state.email, context);
    final nameError = AppValidator.emptyFieldValidated(state.name, context);
    final passError = AppValidator.emptyFieldValidated(state.password, context);
    final confirmPassError =
        AppValidator.emptyFieldValidated(state.password, context);
    final phoneError =
        AppValidator.emptyFieldValidated(state.password, context);

    if (state.password.compareTo(state.confirmPassword) != 0) {
      emit(state.copyWith(isWrongPassword: true));
      return false;
    }

    emit(state.copyWith(
        emailValidated: emailError,
        phoneValidated: phoneError,
        nameValidated: nameError));
    return StringUtils.isNullOrEmpty(emailError) &&
        StringUtils.isNullOrEmpty(passError) &&
        StringUtils.isNullOrEmpty(confirmPassError) &&
        StringUtils.isNullOrEmpty(phoneError) &&
        StringUtils.isNullOrEmpty(nameError);
  }

  Future loginDecision(MResult<MUser> result, {MSocialType? socialType}) async {
    if (result.isSuccess) {
      emit(state.copyWith(status: SignUpStatus.successed));
      // TODO: Add logic Navigate to Syncing data screen
    } else {
      emit(state.copyWith(status: SignUpStatus.failed));
      XToast.error(result.error);
    }
  }

  Future loginSocialDecision(
      MResult<MSocialUser> result, MSocialType socialType) async {
    if (result.isSuccess) {
      final data = result.data!;
      if (socialType == MSocialType.google) {
        connectBEWithGoogle(data);
      }
    } else {
      emit(state.copyWith(status: SignUpStatus.failed));
    }
  }

  Future connectBEWithGoogle(MSocialUser user) async {
    final result = await domain.sign.connectBEWithGoogle(user);
    return loginDecision(result, socialType: user.type);
  }

  void onChangedEmail(String email) {
    emit(state.copyWith(email: email, emailValidated: ''));
  }

  void onChangedName(String name) {
    emit(state.copyWith(name: name, nameValidated: ''));
  }

  void onChangedPhoneNumber(String phone) {
    emit(state.copyWith(phone: phone, phoneValidated: ''));
  }

  void onChangedPassword(String pass, BuildContext context) {
    if (pass.length == AppConstantData.passwordLength) hideKeyboard(context);
    emit(state.copyWith(
      password: pass,
      isWrongPassword: false,
    ));
  }

  void onChangedConfirmPassword(String pass, BuildContext context) {
    if (pass.length == AppConstantData.passwordLength) hideKeyboard(context);
    emit(state.copyWith(
      confirmPassword: pass,
      isWrongPassword: false,
    ));
  }

  setCountryCode(CountryCode value) {
    emit(state.copyWith(country: value));
  }

  onChangedCountryCode(String value) {}

  void setAvatar(Uint8List avatar) {
    emit(state.copyWith(avatar: avatar));
  }

  void resetStatus() {
    emit(state.copyWith(status: SignUpStatus.init));
  }
}
