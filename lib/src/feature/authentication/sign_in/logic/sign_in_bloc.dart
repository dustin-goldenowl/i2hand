import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:i2hand/package/dismiss_keyboard/dismiss_keyboard.dart';
import 'package:i2hand/src/config/constants/app_const.dart';
import 'package:i2hand/src/dialog/toast_wrapper.dart';
import 'package:i2hand/src/feature/authentication/sign_in/logic/sign_in_state.dart';
import 'package:i2hand/src/network/data/user/user_repository.dart';
import 'package:i2hand/src/network/model/common/result.dart';
import 'package:i2hand/src/network/model/common/social_type.dart';
import 'package:i2hand/src/network/model/domain_manager.dart';
import 'package:i2hand/src/network/model/social_user/social_user.dart';
import 'package:i2hand/src/network/model/user/user.dart';
import 'package:i2hand/src/service/shared_pref.dart';
import 'package:i2hand/src/utils/string_utils.dart';
import 'package:i2hand/src/utils/utils.dart';
import 'package:i2hand/src/utils/validated.dart';

class SignInBloc extends Cubit<SignInState> {
  SignInBloc() : super(SignInState());

  DomainManager get domain => DomainManager();

  Future<void> initialData() async {
    final user = SharedPrefs.I.getUser();
    emit(state.copyWith(user: user));
  }

  Future checkEmailIsValidInServer(BuildContext context) async {
    if (state.status == SignInStatus.signingIn) return;
    if (!isValidatedInput(context)) {
      emitSignInFailed();
      return;
    }
    emit(state.copyWith(status: SignInStatus.signingIn));
    final email = state.email;
    try {
      final users = await GetIt.I.get<UserRepository>().getUsers();
      if (isNullOrEmpty(users.data)) {
        emitSignInFailed();
        return;
      }
      for (MUser user in users.data!) {
        if (user.email == email) {
          emit(state.copyWith(status: SignInStatus.successed));
          SharedPrefs.I.setUser(user);
          return;
        }
      }
      emitSignInFailed();
    } catch (e) {
      emitSignInFailed();
    }
  }

  void emitSignInFailed() {
    emit(state.copyWith(status: SignInStatus.failed));
  }

  Future loginWithEmail() async {
    if (state.status == SignInStatus.signingIn) return;
    emit(state.copyWith(status: SignInStatus.signingIn));
    final email = state.user?.email ?? '';
    final password = state.password;
    try {
      final result =
          await domain.sign.loginWithEmail(email: email, password: password!);
      return loginDecision(result);
    } catch (e) {
      emitWrongPass();
      emitSignInFailed();
    }
  }

  void emitWrongPass() {
    if (state.password != null) {
      emit(state.copyWith(isWrongPassword: true, isShowForgotPass: true));
    }
  }

  Future loginWithGoogle(BuildContext context) async {
    if (state.status == SignInStatus.signingIn) return;
    emit(state.copyWith(
      status: SignInStatus.signingIn,
      loginType: MSocialType.google,
    ));
    final result = await domain.sign.loginWithGoogle();
    return loginSocialDecision(result, MSocialType.google);
  }

  bool isValidatedInput(BuildContext context) {
    final emailError = AppValidator.emailValidated(state.email, context);
    emit(state.copyWith(emailValidated: emailError));
    return StringUtils.isNullOrEmpty(emailError);
  }

  Future loginDecision(MResult<MUser> result, {MSocialType? socialType}) async {
    if (result.isSuccess) {
      emit(state.copyWith(status: SignInStatus.successed));
      // TODO: Add logic Navigate to Syncing data screen
    } else {
      emitWrongPass();
      emit(state.copyWith(status: SignInStatus.failed));
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
      emit(state.copyWith(status: SignInStatus.failed));
    }
  }

  Future connectBEWithGoogle(MSocialUser user) async {
    final result = await domain.sign.connectBEWithGoogle(user);
    return loginDecision(result, socialType: user.type);
  }

  void onChangedEmail(String email) {
    emit(state.copyWith(email: email, emailValidated: ''));
  }

  void onChangedPassword(BuildContext context, String pass) {
    emit(state.copyWith(
      password: pass,
      isWrongPassword: false,
    ));
    if (pass.length == AppConstantData.passwordLength) {
      hideKeyboard(context);
      loginWithEmail();
    }
  }
}
