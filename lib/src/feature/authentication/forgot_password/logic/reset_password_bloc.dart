import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:i2hand/src/feature/authentication/forgot_password/logic/reset_password_state.dart';
import 'package:i2hand/src/localization/localization_utils.dart';
import 'package:i2hand/src/network/data/sign/sign_repository.dart';
import 'package:i2hand/src/network/model/user/user.dart';
import 'package:i2hand/src/utils/utils.dart';

class ResetPasswordBloc extends Cubit<ResetPasswordState> {
  ResetPasswordBloc(MUser user) : super(ResetPasswordState(user: user));

  void onChangedOption(String value) {
    emit(state.copyWith(selectedOption: value));
  }

  Future<void> resetPassword(BuildContext context) async {
    if (state.status == ResetPasswordStatus.loading) return;
    if (state.selectedOption.compareTo(S.of(context).sms) == 0) {
      emitSendMailFailed();
      return;
    }
    emit(state.copyWith(status: ResetPasswordStatus.loading));
    final email = state.user.email ?? '';
    try {
      final result = await GetIt.I<SignRepository>().forgotPassword(email);
      if (result.data == true) {
        emit(state.copyWith(status: ResetPasswordStatus.successed));
        return;
      }
    } catch (e) {
      xLog.e(e);
      emitSendMailFailed();
    }
  }

  void initial(BuildContext context) {
    emit(state.copyWith(selectedOption: S.of(context).sms));
  }

  void emitSendMailFailed() {
    emit(state.copyWith(status: ResetPasswordStatus.failed));
  }

  void resetStatus() {
    emit(state.copyWith(status: ResetPasswordStatus.init));
  }
}
